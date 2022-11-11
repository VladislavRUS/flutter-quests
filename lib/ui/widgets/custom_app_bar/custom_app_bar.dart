import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.cornflowerBlue,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(Assets.ellipse),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(Assets.cloud),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: leading,
            actions: actions,
            toolbarHeight: preferredSize.height,
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ColorPalette.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(UI.appBarHeight);
}
