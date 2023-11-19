import 'package:course/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:course/src/auth/data/repositories/auth_repository_implementation.dart';
import 'package:course/src/auth/domain/repositories/auth_repository.dart';
import 'package:course/src/auth/domain/usecases/create_user.dart';
import 'package:course/src/auth/domain/usecases/get_users.dart';
import 'package:course/src/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => AuthCubit(
          createUser: sl(),
          getUsers: sl(),
        ))

    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Repositories
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImplementation(sl()))

    // Data Source
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
