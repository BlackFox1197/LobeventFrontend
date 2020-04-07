import 'package:auditergy_flutter/data/datasources/local_data_source/solar_installation_local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/local_data_source/user_local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/remote_data_source/solar_installation_remote_data_source.dart';
import 'package:auditergy_flutter/data/datasources/remote_data_source/user_remote_data_source.dart';
import 'package:auditergy_flutter/data/repositories/solar_installation_repository_impl.dart';
import 'package:auditergy_flutter/data/repositories/user_repository_impl.dart';
import 'package:auditergy_flutter/domain/core/network/network_info.dart';
import 'package:auditergy_flutter/domain/core/util/input_converter.dart';
import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/create_solar_installation_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/delete_solar_installation_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/get_solar_installations_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/delete_account_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/forgot_password_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/login_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/logout_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/register_usecase.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/bloc/my_account_bloc.dart';
import 'package:auditergy_flutter/ui/bloc/user/user_bloc.dart';
import 'package:auditergy_flutter/ui/bloc/user/user_logout_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'domain/core/constants/constants.dart';
import 'package:http/http.dart' as http;

import 'domain/usecases/user_usecases/update_user_data_usecase.dart';

final sl = GetIt.instance; //(IV) service locator

Future<void> init() async {
  //! Features - User
  //Bloc
  sl.registerFactory(() => MyAccountBloc(
      deleteAccount: sl(), getCurrentUser: sl(), updateUserData: sl()));
  sl.registerFactory(() => UserLoginBloc(login: sl(), register: sl()));
  sl.registerFactory(() => UserLogoutBloc(logout: sl()));
  sl.registerFactory(() => ForgotPasswordBloc(forgotPassword: sl()));
  sl.registerFactory(() => SidebarBloc(
        getCurrentUserUseCase: sl(),
      ));
  //Use cases
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserDataUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  //Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));
  //Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(boxName: HIVE_BOX_NAME, hiveDb: Hive));
  //!External
  sl.registerLazySingleton(() => http.Client());

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! Features - SolarInstallation
  // A) Create SolarInstallation
  //Blocs
  sl.registerFactory(() => CreateSolarInstallationBloc(
        createSolarInstallationUseCase: sl(),
        getCurrentUserUseCase: sl(),
      ));
  sl.registerFactory(() => DashboardBloc(
        getCurrentUserUseCase: sl(),
        getSolarInstallationsUseCase: sl(),
      ));
  sl.registerFactory(() => DeleteSolarInstallationBloc(
        deleteSolarInstallationUseCase: sl(),
      ));
  //Use cases
  sl.registerLazySingleton(() => CreateSolarInstallationUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => GetSolarInstallationsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSolarInstallationUseCase(sl()));
  //Repository
  sl.registerLazySingleton<SolarInstallationRepository>(() =>
      SolarInstallationRepositoryImpl(
          localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));
  //Data sources
  sl.registerLazySingleton<SolarInstallationRemoteDataSource>(
      () => SolarInstallationRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<SolarInstallationLocalDataSource>(() =>
      SolarInstallationLocalDataSourceImpl(
          boxName: HIVE_BOX_NAME, hiveDb: Hive));
  //! Core
  //sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //!External
  //sl.registerLazySingleton(() => http.Client()); ??
  sl.registerLazySingleton(() => DataConnectionChecker());
}
