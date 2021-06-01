import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/presentation/pages/register_screen.dart';
import 'package:resutoran_app/core/presentation/provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  AnimationController _fadeController;
  AnimationController _flipController;
  AnimationController _scaleController;

  Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _flipController.forward();
        }
      });

    _flipController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleController.forward();
        }
      });

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _flipAnimation = Tween<double>(begin: pi / 2, end: 0).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.easeOutBack,
      ),
    );

    Future.delayed(Duration(milliseconds: 250), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    _fadeController.dispose();
    _flipController.dispose();
    _scaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(150), BlendMode.darken),
                child: Image.asset(
                  'images/auth_background.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeController,
                        child: Image.asset(
                          'images/app_icon.png',
                          width: 150,
                        ),
                      ),
                      SizedBox(height: 8),
                      FadeTransition(
                        opacity: _fadeController,
                        child: Text(
                          'RESUTORAN',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 32),
                      AnimatedBuilder(
                        builder: (context, child) => Transform(
                          transform: Matrix4.rotationX(_flipAnimation.value),
                          child: child,
                          alignment: Alignment.center,
                        ),
                        animation: _flipAnimation,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          shadowColor: Theme.of(context).primaryColor,
                          elevation: 5,
                          child: Container(
                            width: 350,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _emailController,
                                        validator: (email) {
                                          return GetUtils.isEmail(email)
                                              ? null
                                              : 'Email tidak valid';
                                        },
                                        decoration: _loginFormDecoration(
                                          context,
                                          hintText: 'Email',
                                          prefixIcon: FontAwesomeIcons.userAlt,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _hidePassword,
                                        validator: (password) {
                                          return password.length > 6
                                              ? null
                                              : 'Password minimal terdiri dari 6 karakter';
                                        },
                                        decoration: _loginFormDecoration(
                                          context,
                                          hintText: 'Password',
                                          prefixIcon: FontAwesomeIcons.lock,
                                        ).copyWith(
                                          suffixIcon: IconButton(
                                            icon: Icon(_hidePassword
                                                ? FontAwesomeIcons.eye
                                                : FontAwesomeIcons.eyeSlash),
                                            onPressed: () => setState(() {
                                              _hidePassword = !_hidePassword;
                                            }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Lupa Password?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      String _email =
                                          _emailController.text.trim();
                                      String _password =
                                          _passwordController.text.trim();

                                      auth.loginWithEmail(_email, _password);
                                    }
                                  },
                                  child: Text(
                                    'MASUK',
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: Colors.white),
                                  ),
                                  style: _loginFormButtonStyle(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextButton(
                                  onPressed: () =>
                                      Get.toNamed(RegisterScreen.routeName),
                                  child: Text(
                                    'DAFTAR',
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  style: _loginFormButtonStyle(),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'ATAU MASUK DENGAN',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.facebookF,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            auth.loginWithFacebook(),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(width: 16),
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.google,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => auth.loginWithGoogle(),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: auth.state == ConnectionState.waiting,
                child: Container(
                  color: Colors.black.withAlpha(125),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  InputDecoration _loginFormDecoration(
    BuildContext context, {
    String hintText,
    IconData prefixIcon,
  }) {
    double _roundedValue = 50;

    return InputDecoration(
      hintText: hintText ?? 'Hint Text',
      hintStyle:
          Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
      prefixIcon: Icon(prefixIcon ?? FontAwesomeIcons.coffee),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(_roundedValue),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(_roundedValue),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(_roundedValue),
        ),
      ),
      filled: true,
      fillColor: Colors.grey.withAlpha(100),
    );
  }

  ButtonStyle _loginFormButtonStyle({
    Color backgroundColor,
  }) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        backgroundColor ?? Colors.white,
      ),
      overlayColor: MaterialStateProperty.all(
        Colors.black.withAlpha(50),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: 48,
          vertical: 16,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
      ),
      elevation: MaterialStateProperty.all(2),
    );
  }
}
