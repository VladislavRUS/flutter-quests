import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_quests/core/constants/ui.dart';
import 'package:flutter_quests/core/theme/color_palette.dart';
import 'package:flutter_quests/core/utils/determine_position.dart';
import 'package:flutter_quests/core/utils/show_snackbar.dart';
import 'package:flutter_quests/data/models/step/geolocation_step/geolocation_step_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GeolocationStepBuilder extends StatefulWidget {
  final GeolocationStepModel step;

  const GeolocationStepBuilder({
    Key? key,
    required this.step,
  }) : super(key: key);

  @override
  State<GeolocationStepBuilder> createState() => _GeolocationStepBuilderState();
}

class _GeolocationStepBuilderState extends State<GeolocationStepBuilder> {
  final _defaultPosition = LatLng(51.5, -0.09);
  final _mapController = MapController();

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    try {
      final position = await determinePosition();

      widget.step.onLatLngChange(position);
    } catch (e) {
      widget.step.onLatLngChange(_defaultPosition);
      showSnackBar(context, 'Не удалось получить текущую геопозицию');
    }
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMove) {
      widget.step.onLatLngChange(event.center);
    }
  }

  void _onMapReady() {
    _mapController.move(widget.step.latLng!, 11);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (widget.step.latLng == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Широта: ${widget.step.latLng!.latitude.toStringAsFixed(3)}, '
              'высота: ${widget.step.latLng!.longitude.toStringAsFixed(3)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
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
                  mapController: _mapController,
                  options: MapOptions(
                    onMapEvent: _onMapEvent,
                    rotation: 0,
                    onMapReady: _onMapReady,
                    center: widget.step.latLng,
                    interactiveFlags: InteractiveFlag.drag |
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapZoom,
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
                          point: widget.step.latLng!,
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
          ],
        );
      },
    );
  }
}
