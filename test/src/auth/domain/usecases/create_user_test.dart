import 'package:course/src/auth/domain/repositories/auth_repository.dart';
import 'package:course/src/auth/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthRepository repository;

  const params = CreateUserParams.empty();

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  test(
    'should call the [AuthRepo.createUser]',
    () async {
      // Arrange
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repository.createUser(
            createdAt: params.createdAt,
            name: params.name,
            avatar: params.avatar,
          )).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
