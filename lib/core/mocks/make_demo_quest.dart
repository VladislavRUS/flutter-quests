import 'package:flutter_quests/core/constants/assets.dart';
import 'package:flutter_quests/core/utils/get_id.dart';
import 'package:flutter_quests/core/utils/write_asset_file.dart';
import 'package:flutter_quests/data/models/hint/hint_model.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';

Future<QuestModel> makeDemoQuest() async {
  final quest = QuestModel(
    id: 'demo',
    title: 'Инопланетная высадка',
    description: 'Небольшой демо квест',
  );

  // Шаг 1
  final textStep1 = TextStepModel();
  textStep1.id = 'textStep1';
  textStep1.title = 'Куда это мы попали?';
  textStep1.question =
      'Привет! В результате неудачного эксперимента по телепортации ты оказался на другой планете. '
      '\nКак думаешь, куда ты попал?';

  textStep1.answer = 'Марс';

  final firstHint = HintModel();
  firstHint.text = 'Планета названа в честь древнеримского бога войны';
  firstHint.seconds = 2;

  textStep1.hints.add(firstHint);

  final secondHint = HintModel();
  secondHint.text = 'Такое же название есть у батончика из нуги в шоколадке';
  secondHint.seconds = 4;

  textStep1.hints.add(secondHint);

  quest.steps.add(textStep1);

  // Шаг 2
  final slideStep2 = SlideStepModel();
  slideStep2.id = 'slideStep2';
  slideStep2.title = 'Посмотрим, что это за планета';
  slideStep2.previous.stepId = textStep1.id;

  // Слайд 1
  final slide1 = SlideModel();
  slide1.text = 'Марс на рассвете';
  final marsImagePath1 = await writeAssetFile(Assets.mars1, 'mars_1.png');
  final marsImage1 = ImageModel(id: getId(), path: marsImagePath1);

  slide1.images.add(marsImage1);

  // Слайд 2
  final slide2 = SlideModel();
  slide2.text = 'Марс целиком';
  final marsImagePath2 = await writeAssetFile(Assets.mars2, 'mars_2.png');
  final marsImage2 = ImageModel(id: getId(), path: marsImagePath2);

  slide2.images.add(marsImage2);

  // Слайд 3
  final slide3 = SlideModel();
  slide3.text = 'Поверхность Марса';
  final marsImagePath3 = await writeAssetFile(Assets.mars3, 'mars_3.png');
  final marsImage3 = ImageModel(id: getId(), path: marsImagePath3);

  final marsImagePath4 = await writeAssetFile(Assets.mars4, 'mars_4.png');
  final marsImage4 = ImageModel(id: getId(), path: marsImagePath4);

  slide3.images.addAll([marsImage3, marsImage4]);

  slideStep2.slides.addAll([slide1, slide2, slide3]);

  quest.steps.add(slideStep2);

  // Шаг 3
  final selectStep3 = SelectStepModel();
  selectStep3.id = 'selectStep3';
  selectStep3.title = 'Как будем возвращаться?';
  selectStep3.question =
      'Теперь нужно выбрать способ, которым будем добираться домой.';

  selectStep3.previous.stepId = slideStep2.id;

  final option1 = OptionModel(id: getId());
  option1.text = 'Попробуем еще раз телепорт';
  option1.isCorrect = true;

  final option2 = OptionModel(id: getId());
  option2.text = 'Полетим на космическом корабле';
  option2.isCorrect = true;

  selectStep3.options.addAll([option1, option2]);

  quest.steps.add(selectStep3);

  // Шаг 4-5
  // 4. Шаг со слайдом с неудачным завершением
  final slideStep4 = SlideStepModel();
  slideStep4.id = 'slideStep4';
  slideStep4.title = 'Неудача';

  final previous1 = BranchPreviousModel();

  previous1.stepId = selectStep3.id;
  previous1.optionId = option1.id;

  slideStep4.previous = previous1;

  // Слайд
  final slide4 = SlideModel();
  slide4.text =
      'Увы, телепорт опять промахнулся, Вы оказались в океане и рядом была голодная акула';
  final sharkImagePath = await writeAssetFile(Assets.shark, 'shark.png');
  final sharkImage = ImageModel(id: getId(), path: sharkImagePath);

  slide4.images.add(sharkImage);

  slideStep4.slides.add(slide4);

  quest.steps.add(slideStep4);

  // 5. Шаг со слайдом с удачным завершением
  final slideStep5 = SlideStepModel();
  slideStep5.id = 'slideStep5';
  slideStep5.title = 'Успех';

  final previous2 = BranchPreviousModel();

  previous2.stepId = selectStep3.id;
  previous2.optionId = option2.id;

  slideStep5.previous = previous2;

  // Слайд
  final slide5 = SlideModel();
  slide5.text = 'Отлично, Вы успешно вернулись на космическом корабле';
  final spaceshipImagePath =
      await writeAssetFile(Assets.spaceship, 'spaceship.png');
  final spaceshipImage = ImageModel(id: getId(), path: spaceshipImagePath);

  slide5.images.add(spaceshipImage);

  slideStep5.slides.add(slide5);

  quest.steps.add(slideStep5);

  return quest;
}
