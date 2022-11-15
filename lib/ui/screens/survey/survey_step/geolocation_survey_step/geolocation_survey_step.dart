// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/determine_position.dart';
import 'package:flutter_quests/core/utils/show_snackbar.dart';
import 'package:flutter_quests/data/models/step/geolocation_step/geolocation_step_model.dart';
import 'package:flutter_quests/data/store/root/root_store.dart';
import 'package:flutter_quests/ui/screens/survey/survey_step/submit_button/submit_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class GeolocationSurveyStep extends StatelessWidget {
  final GeolocationStepModel step;
  final VoidCallback onSubmit;

  final _minDistanceMeters = 50;

  const GeolocationSurveyStep({
    Key? key,
    required this.step,
    required this.onSubmit,
  }) : super(key: key);

  void _onSubmit(BuildContext context) async {
    try {
      final position = await determinePosition();

      final meters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        step.latLng!.latitude,
        step.latLng!.longitude,
      );

      if (meters < _minDistanceMeters) {
        onSubmit();
      } else {
        showSnackBar(
          context,
          'Вы пока слишком далеко!',
          backgroundColor: ColorPalette.bittersweet,
        );
      }
    } catch (e) {
      showSnackBar(context, 'Не удалось получить геопозицию');
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyStore = context.read<RootStore>().surveyStore;

    return Observer(builder: (_) {
      final answered = surveyStore.isStepAnswered(step.id!);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Вам необходимо прийти сюда:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorPalette.shipGray,
            ),
          ),
          const SizedBox(
            height: UI.formFieldSpacing,
          ),
          LayoutBuilder(
            builder: (_, constraints) => SizedBox(
              width: constraints.maxWidth,
              height: 300,
              child: FlutterMap(
                mapController: MapController(),
                options: MapOptions(
                  rotation: 0,
                  center: step.latLng,
                  interactiveFlags: InteractiveFlag.pinchZoom,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40,
                        height: 40,
                        point: step.latLng!,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: ColorPalette.bittersweet,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          SubmitButton(
            answered: answered,
            onSubmit: () => _onSubmit(context),
          ),
        ],
      );
    });
  }
}
