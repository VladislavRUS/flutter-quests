import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_quests/ui/screens/create_quest/create_quest_screen.dart';
import 'package:flutter_quests/ui/screens/create_step/create_step_screen.dart';
import 'package:flutter_quests/ui/screens/home/home_screen.dart';
import 'package:flutter_quests/ui/screens/quests/quests_screen.dart';

import 'app_routes.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: HomeScreen,
      path: AppRoutes.home,
    ),
    AutoRoute(
      page: CreateQuestScreen,
      path: AppRoutes.createQuest,
    ),
    AutoRoute(
      page: CreateStepScreen,
      path: AppRoutes.createStep,
    ),
    AutoRoute(
      page: QuestsScreen,
      path: AppRoutes.quests,
    ),
  ],
)
class AppRouter extends _$AppRouter {
  String makePath(
    String path, {
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
  }) {
    String result = path;

    if (pathParams != null) {
      pathParams.forEach((key, value) {
        result = result.replaceAll(':$key', value);
      });
    }

    if (queryParams != null) {
      result += '?';

      queryParams.forEach((key, value) {
        result += '$key=$value';
      });
    }

    return result;
  }
}
