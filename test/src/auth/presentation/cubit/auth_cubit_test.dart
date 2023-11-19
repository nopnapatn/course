import 'package:bloc_test/bloc_test.dart';
import 'package:course/core/errors/failure.dart';
import 'package:course/src/auth/domain/usecases/create_user.dart';
import 'package:course/src/auth/domain/usecases/get_users.dart';
import 'package:course/src/auth/presentation/cubit/auth_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initail state should be [AuthInitial]', () async {
    expect(cubit.state, const AuthInitial());
  });

  group('createUser', () {
    blocTest<AuthCubit, AuthState>(
        'should emit [CreatingUser, UserCreated] when successful',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.createUser(
              createdAt: tCreateUserParams.createdAt,
              name: tCreateUserParams.name,
              avatar: tCreateUserParams.avatar,
            ),
        expect: () => const [
              CreatingUser(),
              UserCreated(),
            ],
        verify: (_) {
          verify(
            () => createUser(tCreateUserParams),
          ).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthCubit, AuthState>(
      'should emit [CreatingUser, AuthError] when unsuccessful',
      build: () {
        when(
          () => createUser(any()),
        ).thenAnswer((_) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => [
        const CreatingUser(),
        AuthError(tApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => createUser(tCreateUserParams),
        ).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group('getUsers', () {
    blocTest<AuthCubit, AuthState>(
      'should emit [GettingUsers, UsersLoaded] when successful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const [
        GettingUsers(),
        UsersLoaded([]),
      ],
      verify: (_) {
        verify(
          () => getUsers,
        ).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [GettingUsers, UsersLoaded] when unsuccessful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsers(),
        AuthError(tApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => getUsers,
        ).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
