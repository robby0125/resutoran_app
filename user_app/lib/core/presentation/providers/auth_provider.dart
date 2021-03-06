import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';
import 'package:resutoran_app/core/domain/resource.dart';
import 'package:resutoran_app/core/domain/usecases/auth_usecase.dart';
import 'package:resutoran_app/core/domain/usecases/firestore_usecase.dart';
import 'package:resutoran_app/core/presentation/pages/main_screen.dart';

class AuthProvider extends ChangeNotifier {
  final AuthUseCase _authUseCase;
  final FirestoreUseCase _firestoreUseCase;

  AuthProvider(
    this._authUseCase,
    this._firestoreUseCase,
  );

  ConnectionState _state;

  ConnectionState get state => _state;

  UserEntity _user;

  UserEntity get user => _user;

  Future<void> loginWithEmail(
    String email,
    String pass,
  ) async {
    _loading();
    final _resource = await _authUseCase.loginWithEmail(email, pass);
    _handleResult(_resource);
  }

  Future<void> registerWithEmail(
    String name,
    String email,
    String pass,
  ) async {
    _loading();
    final _resource = await _authUseCase.registerWithEmail(name, email, pass);
    if (_resource.body != null)
      loginWithEmail(email, pass);
    else
      _handleResult(_resource);
  }

  Future<void> loginWithFacebook() async {
    _loading();
    final _resource = await _authUseCase.loginWithFacebook();
    _handleResult(_resource);
  }

  Future<void> loginWithGoogle() async {
    _loading();
    final _resource = await _authUseCase.loginWithGoogle();
    _handleResult(_resource);
  }

  Future<void> signOut() async {
    await _authUseCase.signOut();
    _user = null;
    _failed();
  }

  void _loading() {
    _state = ConnectionState.waiting;
    notifyListeners();
  }

  void _failed() {
    _state = ConnectionState.none;
    notifyListeners();
  }

  void _handleResult(Resource<UserEntity> _resource) {
    if (_resource.body != null) {
      _state = ConnectionState.done;
      notifyListeners();

      _user = _resource.body;

      _firestoreUseCase.addRegisteredUser(_user);

      Get.offAllNamed(MainScreen.routeName);
    } else {
      _failed();

      if (_resource.message != null) {
        Get.defaultDialog(
          content: Text(_resource.message),
        );
      }
    }
  }
}
