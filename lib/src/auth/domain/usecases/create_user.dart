import 'package:course/core/usecases/usecase.dart';
import 'package:course/core/utils/typedef.dart';
import 'package:course/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(
    this._repository,
  );

  final AuthRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
        createdAt: params.createAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.createAt,
    required this.name,
    required this.avatar,
  });

  final String createAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [createAt, name, avatar];
}
