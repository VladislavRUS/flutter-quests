import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SurveyFinishedPlaceholder extends StatelessWidget {
  const SurveyFinishedPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.celebratePerson),
        const SizedBox(
          height: 33,
        ),
        const Text(
          'Ура! Вы завершили квест, поздравляем!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: ColorPalette.shipGray,
          ),
        ),
      ],
    );
  }
}
