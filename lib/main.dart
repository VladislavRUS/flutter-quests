import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_canvas/tap_canvas.dart';

import 'core/routing/app_router.dart';
import 'data/store/root/root_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _rootStore = RootStore();
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _rootStore),
        ChangeNotifierProvider.value(value: _appRouter),
      ],
      child: TapCanvas(
        child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
