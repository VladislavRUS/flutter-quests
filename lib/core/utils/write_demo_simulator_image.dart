import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/utils/load_asset.dart';
import 'package:flutter_quests/core/utils/write_file.dart';

Future<String> writeDemoSimulatorImage() async {
  const demoImageName = 'cat.png';

  final bytes = await loadAsset(Assets.cat);

  return writeFile(demoImageName, bytes);
}
