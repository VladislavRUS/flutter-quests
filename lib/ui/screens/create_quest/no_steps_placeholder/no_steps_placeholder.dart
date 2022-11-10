import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoStepsPlaceholder extends StatelessWidget {
  const NoStepsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.circlePerson),
        const SizedBox(
          height: 33,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              Text(
                'У вас пока нет шагов в квесте',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.shipGray,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Нажмите на кнопку +,\n чтобы создать первый шаг',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6A7B89),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
