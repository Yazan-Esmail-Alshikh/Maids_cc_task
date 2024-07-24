import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maids_cc_task/data/data_source/auth_data_source/auth_remote_data_source.dart';
import 'package:maids_cc_task/data/data_source/home_data_source/home_remote_data_source.dart';
import 'package:maids_cc_task/data/network/app_api.dart';
import 'package:maids_cc_task/data/network/dio_factory.dart';
import 'package:maids_cc_task/data/network/network_info.dart';
import 'package:maids_cc_task/data/repository/auth_repository_impl.dart';
import 'package:maids_cc_task/data/repository/home_repository_impl.dart';
import 'package:maids_cc_task/domain/repository/auth_repository.dart';
import 'package:maids_cc_task/domain/repository/home_repository.dart';
import 'package:maids_cc_task/domain/usecase/auth_use_case/get_refresh_token_use_case.dart';
import 'package:maids_cc_task/domain/usecase/auth_use_case/login_use_case.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/add_new_todo_use_case.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/delete_todo_use_case.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/get_all_todos_use_case.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/update_todo_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_pref.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();

  instance
      .registerLazySingleton<AppServiceClient>(() => AppServiceClientImpl(dio));

  initAuthModel();
  initHomeModel();
}

initAuthModel() {
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance(), instance()));

  instance.registerLazySingleton<GetRefreshTokenUseCase>(
      () => GetRefreshTokenUseCase(instance()));

  instance.registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));
}

initHomeModel() {
  instance.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(instance(), instance(), instance()));

  instance.registerLazySingleton<GetAllTodosUseCase>(
      () => GetAllTodosUseCase(instance()));

  instance.registerLazySingleton<UpdateTodoUseCase>(
      () => UpdateTodoUseCase(instance()));

  instance.registerLazySingleton<AddNewTodoUseCase>(
      () => AddNewTodoUseCase(instance()));

  instance.registerLazySingleton<DeleteTodoUseCase>(
      () => DeleteTodoUseCase(instance()));
}
