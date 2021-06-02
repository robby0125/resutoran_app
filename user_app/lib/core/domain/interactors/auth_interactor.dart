import 'package:resutoran_app/core/domain/entities/user_entity.dart';
import 'package:resutoran_app/core/domain/repositories/auth_repository.dart';
import 'package:resutoran_app/core/domain/resource.dart';
import 'package:resutoran_app/core/domain/usecases/auth_usecase.dart';

class AuthInteractor implements AuthUseCase {
  final AuthRepository _authRepository;

  AuthInteractor(this._authRepository);

  @override
  Future<Resource<UserEntity>> loginWithEmail(
    String email,
    String pass,
  ) =>
      _authRepository.loginWithEmail(email, pass);

  @override
  Future<Resource<UserEntity>> loginWithFacebook() =>
      _authRepository.loginWithFacebook();

  @override
  Future<Resource<UserEntity>> loginWithGoogle() =>
      _authRepository.loginWithGoogle();

  @override
  Future<Resource<UserEntity>> registerWithEmail(
    String name,
    String email,
    String pass,
  ) =>
      _authRepository.registerWithEmail(name, email, pass);

  @override
  Future<void> signOut() => _authRepository.signOut();
}
