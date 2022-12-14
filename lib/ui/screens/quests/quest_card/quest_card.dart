import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/ui/widgets/custom_card/custom_card.dart';
import 'package:flutter_quests/ui/widgets/custom_disabled/custom_disabled.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestCard extends StatelessWidget {
  final QuestModel quest;
  final void Function(QuestModel) onTap;
  final void Function(QuestModel) onShare;
  final bool zipping;

  const QuestCard({
    Key? key,
    required this.quest,
    required this.onTap,
    required this.onShare,
    required this.zipping,
  }) : super(key: key);

  void _onTap() {
    onTap(quest);
  }

  void _onShare() {
    onShare(quest);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quest.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorPalette.shipGray,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              quest.description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorPalette.manatee,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomDisabled(
                  disabled: zipping,
                  child: IconButton(
                    onPressed: _onShare,
                    icon: zipping
                        ? const CircularProgressIndicator()
                        : SvgPicture.asset(
                            Assets.replyIcon,
                            color: ColorPalette.regentGray,
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
