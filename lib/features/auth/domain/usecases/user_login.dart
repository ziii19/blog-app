import 'package:blog_app/core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/common/entities/user.dart';
import '../repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<User, UserLoginParam> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParam params) async {
    return await authRepository.loginWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParam {
  final String email;
  final String password;

  UserLoginParam({required this.email, required this.password});
}
