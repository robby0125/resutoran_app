import 'package:resutoran_app/core/domain/entities/user_entity.dart';
import 'package:resutoran_app/core/domain/resource.dart';

abstract class AuthRepository {
  Future<Resource<UserEntity>> loginWithEmail(
    String email,
    String pass,
  );

  Future<Resource<UserEntity>> registerWithEmail(
    String name,
    String email,
    String pass,
  );

  Future<Resource<UserEntity>> loginWithFacebook();

  Future<Resource<UserEntity>> loginWithGoogle();
}
