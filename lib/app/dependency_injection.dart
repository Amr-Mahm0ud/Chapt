import 'package:chapt/app/theme_controller.dart';
import 'package:chapt/data/data_source/remote_data_source.dart';
import 'package:chapt/data/network/api/app_api.dart';
import 'package:chapt/data/network/dio_factory.dart';
import 'package:chapt/data/network/network_state.dart';
import 'package:chapt/data/repository/repository_implementation.dart';
import 'package:chapt/domain/repository/repository.dart';
import 'package:chapt/domain/use_case/login_use_case.dart';
import 'package:chapt/domain/use_case/send_message_use_case.dart';
import 'package:chapt/domain/use_case/signup_use_case.dart';
import 'package:chapt/presentation/view_models/home/main_view_model.dart';
import 'package:chapt/presentation/view_models/signin/signin_view_model.dart';
import 'package:chapt/presentation/view_models/signup/signup_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // Network Information
  instance.registerLazySingleton<NetworkState>(
      () => NetworkStateImp(InternetConnectionChecker()));

  // Dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  //App service client
  Dio dio = await instance<DioFactory>().getDio();
  instance
      .registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));

  //Remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(instance<AppServicesClient>()));

  //Repository
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImp(instance<NetworkState>(), instance<RemoteDataSource>()));

  //Theme Controller
  instance.registerLazySingleton<ThemeController>(() => ThemeController());
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<Repository>()));
    instance.registerFactory<SigninViewModel>(
        () => SigninViewModel(instance<LoginUseCase>()));
  }
}

Future<void> initRegisterModule() async {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    instance.registerFactory<SignupUseCase>(
        () => SignupUseCase(instance<Repository>()));
    instance.registerFactory<SignupViewModel>(
        () => SignupViewModel(instance<SignupUseCase>()));
  }
}

Future<void> initHomeModule() async {
  if (!GetIt.I.isRegistered<SendMessageUseCase>()) {
    instance.registerFactory<SendMessageUseCase>(
        () => SendMessageUseCase(instance<Repository>()));
    instance.registerFactory<MainViewModel>(
        () => MainViewModel(instance<SendMessageUseCase>()));
  }
}
