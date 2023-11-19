import 'package:course/core/errors/exceptions.dart';
import 'package:course/core/errors/failure.dart';
import 'package:course/core/utils/typedef.dart';
import 'package:course/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:course/src/auth/domain/entities/user.dart';
import 'package:course/src/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImplementation implements AuthRepository {
  const AuthRepositoryImplementation(
    this._remoteDataSource,
  );

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
