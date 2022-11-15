import 'package:flutter/foundation.dart';
import 'package:flutter_quests/core/utils/enum_from_string.dart';
import 'package:flutter_quests/data/enums/step_type.dart';
import 'package:flutter_quests/data/mappers/hint_mapper.dart';
import 'package:flutter_quests/data/mappers/option_mapper.dart';
import 'package:flutter_quests/data/mappers/previous_mapper.dart';
import 'package:flutter_quests/data/mappers/slide_mapper.dart';
import 'package:flutter_quests/data/models/hint/hint_model.dart';
import 'package:flutter_quests/data/models/slide/slide_model.dart';
import 'package:flutter_quests/data/models/step/geolocation_step/geolocation_step_model.dart';
import 'package:flutter_quests/data/models/step/select_step/select_step_model.dart';
import 'package:flutter_quests/data/models/step/slide_step/slide_step_model.dart';
import 'package:flutter_quests/data/models/step/step_model.dart';
import 'package:flutter_quests/data/models/step/text_step/text_step_model.dart';
import 'package:latlong2/latlong.dart';

class StepMapper {
  static Map<String, dynamic> toJson(StepModel step) {
    final json = <String, dynamic>{
      'id': step.id,
      'title': step.title,
      'previous':
          step.previous != null ? PreviousMapper.toJson(step.previous!) : null,
    };

    json['type'] = describeEnum(step.type);

    if (step is TextStepModel) {
      json.addAll(_textStepToJson(step));
    } else if (step is SelectStepModel) {
      json.addAll(_selectStepToJson(step));
    } else if (step is SlideStepModel) {
      json.addAll(_slideStepToJson(step));
    } else if (step is GeolocationStepModel) {
      json.addAll(_geolocationStepToJson(step));
    }

    return json;
  }

  static Map<String, dynamic> _textStepToJson(TextStepModel step) {
    return {
      'question': step.question,
      'answer': step.answer,
      'hints': step.hints.map(HintMapper.toJson).toList(),
    };
  }

  static Map<String, dynamic> _selectStepToJson(SelectStepModel step) {
    return {
      'question': step.question,
      'options': step.options.map(OptionMapper.toJson).toList(),
    };
  }

  static Map<String, dynamic> _slideStepToJson(SlideStepModel step) {
    return {
      'slides': step.slides.map(SlideMapper.toJson).toList(),
    };
  }

  static Map<String, dynamic> _geolocationStepToJson(
      GeolocationStepModel step) {
    return {
      'latitude': step.latLng!.latitude,
      'longitude': step.latLng!.longitude,
    };
  }

  static StepModel fromJson(Map<String, dynamic> json) {
    final type = enumFromString(StepType.values, json['type']);
    StepModel step;

    switch (type) {
      case StepType.text:
        step = _textStepFromJson(json);
        break;
      case StepType.select:
        step = _selectStepFromJson(json);
        break;
      case StepType.slide:
        step = _slideStepFromJson(json);
        break;
      case StepType.geolocation:
        step = _geolocationStepFromJson(json);
        break;
      default:
        throw Exception('Not supported type');
    }

    step.id = json['id'];
    step.title = json['title'];
    step.previous = json['previous'] != null
        ? PreviousMapper.fromJson(json['previous'])
        : null;

    return step;
  }

  static TextStepModel _textStepFromJson(Map<String, dynamic> json) {
    final textStep = TextStepModel();
    textStep.question = json['question'];
    textStep.answer = json['answer'];

    final jsonHints = List<Map<String, dynamic>>.from(json['hints']);

    textStep.hints.addAll(
      jsonHints.map<HintModel>(HintMapper.fromJson).toList(),
    );

    return textStep;
  }

  static SelectStepModel _selectStepFromJson(Map<String, dynamic> json) {
    final selectStep = SelectStepModel();
    selectStep.question = json['question'];

    final options = List<Map<String, dynamic>>.from(json['options']);

    selectStep.options.addAll(options.map(OptionMapper.fromJson));

    return selectStep;
  }

  static SlideStepModel _slideStepFromJson(Map<String, dynamic> json) {
    final slideStep = SlideStepModel();

    final jsonSlides = List<Map<String, dynamic>>.from(json['slides']);

    slideStep.slides.addAll(
      jsonSlides.map<SlideModel>(SlideMapper.fromJson).toList(),
    );

    return slideStep;
  }

  static GeolocationStepModel _geolocationStepFromJson(
      Map<String, dynamic> json) {
    final geolocationStep = GeolocationStepModel();

    geolocationStep.latLng = LatLng(json['latitude'], json['longitude']);

    return geolocationStep;
  }
}
