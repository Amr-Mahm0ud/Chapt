import 'dart:async';

import 'package:chapt/app/app_prefs.dart';
import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';

class ThemeController extends BaseViewModel {
  final StreamController<bool> _themeController =
      StreamController<bool>.broadcast();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  Sink<bool> get inputTheme => _themeController.sink;
  Stream<bool> get ouputTheme => _themeController.stream;

  bool get isDarkTheme => _appPreferences.getTheme();

  changeTheme() {
    _appPreferences.changeTheme();
    inputTheme.add(_appPreferences.getTheme());
  }

  @override
  void start() {
    inputTheme.add(_appPreferences.getTheme());
  }

  @override
  void dispose() {}
}
