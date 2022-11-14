import 'package:flutter/material.dart';
import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/ui/widgets/custom_card/custom_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestCard extends StatelessWidget {
  final QuestModel quest;
  final void Function(QuestModel) onTap;
  final void Function(QuestModel) onShare;

  const QuestCard({
    Key? key,
    required this.quest,
    required this.onTap,
    required this.onShare,
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
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                quest.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.shipGray,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _onShare,
                  icon: SvgPicture.asset(
                    Assets.replyIcon,
                    color: ColorPalette.regentGray,
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
