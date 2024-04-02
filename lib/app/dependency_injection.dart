import 'package:chapt/data/data_source/remote_data_source.dart';
import 'package:chapt/data/network/api/app_api.dart';
import 'package:chapt/data/network/dio_factory.dart';
import 'package:chapt/data/network/network_state.dart';
import 'package:chapt/data/repository/repository_implementation.dart';
import 'package:chapt/domain/repository/repository.dart';
import 'package:chapt/domain/use_case/login_use_case.dart';
import 'package:chapt/presentation/view_models/signin/signin_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
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
  instance.registerLazySingleton<Repositry>(() => RepositoryImp(
      instance<NetworkState>(), instance<RemoteDataSource>()));
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<Repositry>()));
    instance.registerFactory<SigninViewModel>(
        () => SigninViewModel(instance<LoginUseCase>()));
  }
}
