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
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
          createdAt: '_empty.string',
          name: '_empty.string',
          avatar: '_empty,string',
        );

  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
