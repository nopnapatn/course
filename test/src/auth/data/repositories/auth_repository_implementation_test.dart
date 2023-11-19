import 'package:course/core/errors/exceptions.dart';
import 'package:course/core/errors/failure.dart';
import 'package:course/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:course/src/auth/data/repositories/auth_repository_implementation.dart';
import 'package:course/src/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImplementation repoImpl;

  const createdAt = 'whatever.createdAt';
  const name = 'whatever.name';
  const avatar = 'whatever.avatar';
  const tException =
      ApiException(message: 'Unknown error occured', statusCode: 500);

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthRepositoryImplementation(remoteDataSource);
  });

  group('createUser', () {
    test(
        'should call the [RemoteDataSource.createUser] and complete '
        'successfully when the call to the remote source is successful',
        () async {
      // Arrange
      when(() => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(
            named: 'avatar',
          ))).thenAnswer((_) async => Future.value());

      //  Act
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);
    });

    test(
        'should return a [ApiFailure] when the call to the remote '
        'source is unsuccessful', () async {
      // Arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tException);

      // Act
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // Assert
      expect(
          result,
          equals(Left(ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers] and return [List<User>] '
        'when call to remote source is successful', () async {
      when(() => remoteDataSource.getUsers()).thenAnswer((_) async => []);

      final result = await repoImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(
        () => remoteDataSource.getUsers(),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ApiFailure] when the call to the remote '
        'source is unsuccessful', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await repoImpl.getUsers();

      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(
        () => remoteDataSource.getUsers(),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
