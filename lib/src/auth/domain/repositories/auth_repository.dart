import 'package:course/core/utils/typedef.dart';
import 'package:course/src/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
