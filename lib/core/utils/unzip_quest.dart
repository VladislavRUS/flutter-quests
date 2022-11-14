import 'dart:convert';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_quests/data/mappers/quest_mapper.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart';

Future<QuestModel> unzipQuest(String zipFilePath) async {
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  final zipFile = File(zipFilePath);

  final destinationDirPath =
      join(appDocDirectory.path, 'quest_${DateTime.now().toIso8601String()}');

  final destinationDir = Directory(destinationDirPath);

  await ZipFile.extractToDirectory(
    zipFile: zipFile,
    destinationDir: destinationDir,
  );

  final files = destinationDir.listSync();

  final questJsonFileEntity =
      files.firstWhere((file) => file.path.contains('.json'));
  final questJsonFile = File(questJsonFileEntity.path);
  final questJsonString = await questJsonFile.readAsString();
  final questJson = jsonDecode(questJsonString);

  final quest = QuestMapper.fromJson(questJson);

  final imageFileEntities = files.where((file) => !file.path.contains('.json'));

  for (final image in quest.questImages) {
    final imageFileEntity = imageFileEntities.firstWhereOrNull(
        (imageFileEntity) => imageFileEntity.path.contains(image.id));

    if (imageFileEntity != null) {
      image.changePath(imageFileEntity.path);
    }
  }

  return quest;
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
