import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/app/theme_controller.dart';
import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:chapt/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp _app = MyApp._internal(); //singleton
  factory MyApp() => _app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = instance<ThemeController>();
  @override
  void initState() {
    _themeController.start();
    super.initState();
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _themeController.ouputTheme,
        initialData: _themeController.isDarkTheme,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splash,
            darkTheme: getDarkTheme(),
            theme: getLightTheme(),
            themeMode: snapshot.data! ? ThemeMode.dark : ThemeMode.light,
          );
        });
  }
}
