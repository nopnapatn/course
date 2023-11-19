import 'package:course/core/usecases/usecase.dart';
import 'package:course/core/utils/typedef.dart';
import 'package:course/src/auth/domain/entities/user.dart';
import 'package:course/src/auth/domain/repositories/auth_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(
    this._repository,
  );

  final AuthRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
