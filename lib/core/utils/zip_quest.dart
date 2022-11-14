import 'dart:convert';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_quests/data/mappers/quest_mapper.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';

import 'package:path/path.dart';
import 'get_quest_file_title_description.dart';
import 'package:path_provider/path_provider.dart';

Future<ZipQuestResult> zipQuest(QuestModel quest) async {
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  final questFileTitleDescription = getQuestFileTitleDescription(quest);
  final title = questFileTitleDescription.item1;
  final description = questFileTitleDescription.item2;

  final sourceDirPath = join(appDocDirectory.path, title);
  final sourceDir = Directory(sourceDirPath);

  final zipFilePath = join(appDocDirectory.path, '$title.zip');
  final zipFile = File(zipFilePath);

  final directoryExists = await sourceDir.exists();

  if (!directoryExists) {
    await sourceDir.create();

    final questJsonFilePath = join(sourceDir.path, '$title.json');

    final questJsonFile = File(questJsonFilePath);

    await questJsonFile.writeAsString(jsonEncode(QuestMapper.toJson(quest)));

    for (final image in quest.questImages) {
      // Image on current device
      final imageFile = File(image.path);
      final imageBytes = await imageFile.readAsBytes();

      // Image for new device
      final newImageFilePath = join(sourceDir.path, image.id);
      final newImageFile = File(newImageFilePath);

      await newImageFile.writeAsBytes(imageBytes);
    }

    await ZipFile.createFromDirectory(
      sourceDir: sourceDir,
      zipFile: zipFile,
    );
  }

  return ZipQuestResult(
    title: title,
    description: description,
    path: zipFile.path,
  );
}

class ZipQuestResult {
  final String title;
  final String description;
  final String path;

  ZipQuestResult({
    required this.title,
    required this.description,
    required this.path,
  });
}
