import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Greeting extends StatelessWidget {
  const Greeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.helloPerson),
        const SizedBox(
          height: 33,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: 'Добро пожаловать в ',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: ColorPalette.shipGray,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Квестоманию',
                style: TextStyle(
                  color: ColorPalette.cornflowerBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
