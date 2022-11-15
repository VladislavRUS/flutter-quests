import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/get_id.dart';
import 'package:flutter_quests/core/utils/write_asset_file.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_quests/ui/widgets/custom_disabled/custom_disabled.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_io/io.dart';

class CreateSlideToolbar extends StatefulWidget {
  final void Function(ImageModel) onImageAdded;
  final VoidCallback? onSave;
  final bool disabled;

  const CreateSlideToolbar({
    Key? key,
    required this.onImageAdded,
    required this.onSave,
    required this.disabled,
  }) : super(key: key);

  @override
  State<CreateSlideToolbar> createState() => _CreateSlideToolbarState();
}

class _CreateSlideToolbarState extends State<CreateSlideToolbar> {
  final _deviceInfo = DeviceInfoPlugin();

  void _onAddImage() async {
    List<File> files = [];

    if (Platform.isIOS && !(await _deviceInfo.iosInfo).isPhysicalDevice) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Внимание'),
          content: const Text(
            'Симулятор iOS не поддерживает выбор картинок через плагин file_picker, '
            'будет загружена картинка из папки assets.',
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      const demoImageName = 'cat.png';
      final path = await writeAssetFile(Assets.cat, demoImageName);

      files.add(File(path));
    } else {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      files.addAll(result.paths.map((path) => File(path!)));
    }

    for (final file in files) {
      widget.onImageAdded(
        ImageModel(id: getId(), path: file.path),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(
          color: ColorPalette.wildSand,
        ),
      )),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 53,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _onAddImage,
            icon: SvgPicture.asset(
              Assets.pictureIcon,
              color: ColorPalette.grayChateau,
            ),
          ),
          if (widget.onSave != null)
            CustomDisabled(
              disabled: widget.disabled,
              child: IconButton(
                onPressed: widget.onSave,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  Assets.sendIcon,
                ),
              ),
            )
        ],
      ),
    );
  }
}
