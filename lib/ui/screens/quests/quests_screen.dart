import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/routing/app_router.dart';
import 'package:flutter_quests/core/routing/app_routes.dart';
import 'package:flutter_quests/core/utils/get_quest_file_title_description.dart';
import 'package:flutter_quests/core/utils/write_file.dart';
import 'package:flutter_quests/data/mappers/quest_mapper.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter_quests/ui/widgets/custom_button/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';

import 'quest_card/quest_card.dart';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({Key? key}) : super(key: key);

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    final questsStore = context.read<RootStore>().questsStore;

    await questsStore.initQuests();
  }

  void _onLoad(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) {
      return;
    }

    final filePath = result.files.single.path;

    if (filePath == null) {
      return;
    }

    final file = File(filePath);
  }

  void _onTap(BuildContext context, QuestModel quest) {
    final surveyStore = context.read<RootStore>().surveyStore;

    surveyStore.init(quest);

    final appRouter = context.read<AppRouter>();

    appRouter.pushNamed(AppRoutes.survey);
  }

  void _onShare(BuildContext context, QuestModel quest) async {
    final questFileTitleDescription = getQuestFileTitleDescription(quest);

    final fileName = '${questFileTitleDescription.item1}.json';

    final path =
        await writeFile(fileName, jsonEncode(QuestMapper.toJson(quest)));

    await Share.shareXFiles(
      [XFile(path)],
      text: questFileTitleDescription.item1,
      subject: questFileTitleDescription.item2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final questsStore = context.read<RootStore>().questsStore;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Доступные квесты',
        leading: BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Observer(builder: (_) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final quest = questsStore.quests[index];

                      return QuestCard(
                          quest: quest,
                          onTap: (quest) => _onTap(context, quest),
                          onShare: (quest) => _onShare(context, quest));
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: questsStore.quests.length,
                  );
                }),
              ),
              CustomButton(
                onTap: () => _onLoad(context),
                text: 'Загрузить из файла',
                color: CustomButtonColor.secondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
