import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resutoran_app/core/presentation/pages/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  ConnectionState _state;

  ConnectionState get state => _state;

  User _user;

  User get user => _user;

  Future<void> login({
    @required String email,
    @required String password,
  }) async {
    try {
      _state = ConnectionState.waiting;
      notifyListeners();

      final _user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_user != null) {
        _state = ConnectionState.done;
        notifyListeners();

        this._user = _user.user;

        Get.offAllNamed(HomeScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      _state = ConnectionState.none;
      notifyListeners();

      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          content: Text(
            'User tidak ditemukan, silahkan mendaftar terlebih dahulu.',
            textAlign: TextAlign.center,
          ),
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          content: Text(
            'Password salah',
            textAlign: TextAlign.center,
          ),
        );
      }
    }
  }

  Future<void> register({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    try {
      _state = ConnectionState.waiting;
      notifyListeners();

      final _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_user != null) {
        _state = ConnectionState.done;
        notifyListeners();

        this._user = _user.user;
        this._user.updateProfile(displayName: name);

        login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      _state = ConnectionState.none;
      notifyListeners();
    }
  }
}
