import 'package:course/src/auth/domain/entities/user.dart';
import 'package:course/src/auth/domain/repositories/auth_repository.dart';
import 'package:course/src/auth/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late GetUsers usecase;

  const tReponse = [User.empty()];

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  test('should call [AuthRepo.getUsers] and return [List<User>]', () async {
    // Arrange
    when(() => repository.getUsers())
        .thenAnswer(((_) async => const Right(tReponse)));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, List<User>>(tReponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
