import 'package:resutoran_app/core/data/datasources/auth_datasource.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';
import 'package:resutoran_app/core/domain/repositories/auth_repository.dart';
import 'package:resutoran_app/core/domain/resource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Resource<UserEntity>> loginWithEmail(
    String email,
    String pass,
  ) =>
      _authDataSource.loginWithEmail(email, pass);

  @override
  Future<Resource<UserEntity>> loginWithFacebook() =>
      _authDataSource.loginWithFacebook();

  @override
  Future<Resource<UserEntity>> loginWithGoogle() =>
      _authDataSource.loginWithGoogle();

  @override
  Future<Resource<UserEntity>> registerWithEmail(
    String name,
    String email,
    String pass,
  ) =>
      _authDataSource.registerWithEmail(name, email, pass);

  @override
  Future<void> signOut() => _authDataSource.signOut();
}
