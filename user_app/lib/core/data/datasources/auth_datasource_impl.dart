import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resutoran_app/core/data/datasources/auth_datasource.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';
import 'package:resutoran_app/core/domain/resource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSourceImpl(this._firebaseAuth);

  Resource<UserEntity> _resource = Resource<UserEntity>();

  @override
  Future<Resource<UserEntity>> loginWithEmail(
    String email,
    String pass,
  ) async {
    try {
      final _credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      return _resource.success(_provideUser(_credential.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return _resource.failed(
          'Pengguna dengan alamat Email $email tidak ditemukan, pastikan Email yang Anda gunakan sudah terdaftar',
        );
      } else if (e.code == 'wrong-password') {
        return _resource.failed(
          'Password yang Anda masukkan salah.',
        );
      }
    } catch (e) {
      return _resource.failed(e.toString());
    }

    return _resource.failed('Terjadi kesalahan tak teridentifikasi.');
  }

  @override
  Future<Resource<UserEntity>> loginWithFacebook() async {
    final _result = await FacebookAuth.instance.login();

    if (_result.status == LoginStatus.success) {
      final _credential = FacebookAuthProvider.credential(
        _result.accessToken.token,
      );

      final _loginResult = await _firebaseAuth.signInWithCredential(
        _credential,
      );

      return _resource.success(_provideUser(_loginResult.user));
    } else if (_result.status == LoginStatus.cancelled) {
      return _resource.failed(null);
    } else {
      return _resource.failed('Terjadi kesalahan!');
    }
  }

  @override
  Future<Resource<UserEntity>> loginWithGoogle() async {
    try {
      final _googleSignIn = await GoogleSignIn().signIn();
      final _auth = await _googleSignIn.authentication;
      final _credential = GoogleAuthProvider.credential(
        accessToken: _auth.accessToken,
        idToken: _auth.idToken,
      );
      final _result = await _firebaseAuth.signInWithCredential(_credential);

      if (_result.user != null) {
        return _resource.success(_provideUser(_result.user));
      }

      return _resource.failed('Terjadi kesalahan!');
    } catch (e) {
      return _resource.failed(null);
    }
  }

  @override
  Future<Resource<UserEntity>> registerWithEmail(
    String name,
    String email,
    String pass,
  ) async {
    try {
      final _credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      final _user = _credential.user;
      _user.updateProfile(displayName: name);

      return _resource.success(_provideUser(_user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return _resource.failed('Email berikut $email telah digunakan.');
      }
    }

    return _resource.failed('Terjadi kesalahan tak teridentifikasi.');
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  UserEntity _provideUser(User user) => UserEntity(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
      );
}
