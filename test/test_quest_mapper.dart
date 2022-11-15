import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_quests/data/enums/previous_type.dart';
import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/mappers/quest_mapper.dart';
import 'package:flutter_quests/data/models/hint/hint_model.dart';
import 'package:flutter_quests/data/models/image/image_model.dart';
import 'package:flutter_quests/data/models/option/option_model.dart';
import 'package:flutter_quests/data/models/previous/branch_previous/branch_previous_model.dart';
import 'package:flutter_quests/data/models/previous/simple_previous/simple_previous_model.dart';
import 'package:flutter_quests/data/models/quest/quest_model.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/data/models/step/geolocation_step/geolocation_step_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() async {
  final testJson = {
    'id': 'test_quest_id',
    'title': 'test_quest',
    'description': 'test_description',
    'steps': [
      {
        'id': 'text_id',
        'title': 'text_title',
        'previous': {
          'type': describeEnum(PreviousType.simple),
          'stepId': 'text_previous',
        },
        'type': describeEnum(StepType.text),
        'question': 'Question',
        'answer': 'Answer',
        'hints': [
          {
            'text': 'Text',
            'seconds': 5,
          }
        ],
      },
      {
        'id': 'select_id',
        'title': 'select_title',
        'previous': {
          'type': describeEnum(PreviousType.simple),
          'stepId': 'select_previous',
        },
        'type': describeEnum(StepType.select),
        'question': 'Question',
        'options': [
          {
            'id': 'first_option',
            'text': 'first',
            'isCorrect': true,
          },
          {
            'id': 'second_option',
            'text': 'second',
            'isCorrect': false,
          },
        ],
      },
      {
        'id': 'slide_id',
        'title': 'slide_title',
        'previous': {
          'type': describeEnum(PreviousType.branch),
          'stepId': 'slide_previous',
          'optionId': 'slide_previous_option',
        },
        'type': describeEnum(StepType.slide),
        'slides': [
          {
            'text': 'slide_text',
            'images': [
              {
                'id': 'image_id',
                'path': 'image_path',
              }
            ],
          }
        ],
      },
      {
        'id': 'geolocation_id',
        'title': 'geolocation_title',
        'previous': {
          'type': describeEnum(PreviousType.simple),
          'stepId': 'geolocation_previous',
        },
        'type': describeEnum(StepType.geolocation),
        'latitude': 0.0,
        'longitude': 0.0,
      }
    ]
  };

  final testQuest = QuestModel(
    id: 'test_quest_id',
    title: 'test_quest',
    description: 'test_description',
  );

  // Text step
  final textStep = TextStepModel();

  textStep.id = 'text_id';
  textStep.title = 'text_title';
  textStep.question = 'Question';
  textStep.answer = 'Answer';

  final textPreviousModel = SimplePreviousModel();
  textPreviousModel.stepId = 'text_previous';

  textStep.previous = textPreviousModel;

  final hint = HintModel();
  hint.text = 'Text';
  hint.seconds = 5;

  textStep.hints.add(hint);

  testQuest.steps.add(textStep);

  // Select step
  final selectStep = SelectStepModel();
  selectStep.question = 'Question';
  selectStep.id = 'select_id';
  selectStep.title = 'select_title';

  final option1 = OptionModel(id: 'first_option');
  option1.text = 'first';
  option1.isCorrect = true;

  final option2 = OptionModel(id: 'second_option');
  option2.text = 'second';
  option2.isCorrect = false;

  selectStep.options.addAll([option1, option2]);

  final selectPreviousModel = SimplePreviousModel();
  selectPreviousModel.stepId = 'select_previous';

  selectStep.previous = selectPreviousModel;

  testQuest.steps.add(selectStep);

  // Slide step
  final slideStep = SlideStepModel();
  slideStep.id = 'slide_id';
  slideStep.title = 'slide_title';

  final slide = SlideModel();
  slide.text = 'slide_text';

  final slideImage = ImageModel(id: 'image_id', path: 'image_path');
  slide.images.add(slideImage);

  slideStep.slides.add(slide);

  final slidePreviousModel = BranchPreviousModel();
  slidePreviousModel.stepId = 'slide_previous';
  slidePreviousModel.optionId = 'slide_previous_option';

  slideStep.previous = slidePreviousModel;

  testQuest.steps.add(slideStep);

  // Geolocation step
  final geolocationStep = GeolocationStepModel();
  geolocationStep.id = 'geolocation_id';
  geolocationStep.title = 'geolocation_title';
  geolocationStep.latLng = LatLng(0, 0);

  final geolocationPreviousModel = SimplePreviousModel();
  geolocationPreviousModel.stepId = 'geolocation_previous';

  geolocationStep.previous = geolocationPreviousModel;

  testQuest.steps.add(geolocationStep);

  test('Correctly converting to json', () {
    final expectedJsonString = jsonEncode(testJson);
    final actualJsonString = jsonEncode(QuestMapper.toJson(testQuest));

    expect(expectedJsonString, actualJsonString);
  });

  test('Correctly converting from json', () {
    final expectedJsonString = jsonEncode(testJson);

    final questFromJson = QuestMapper.fromJson(testJson);

    final questFromJsonString = jsonEncode(QuestMapper.toJson(questFromJson));

    expect(questFromJsonString, expectedJsonString);
  });
}
