import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/presentation/provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/app_icon.png',
                          width: 150,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'RESUTORAN',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 32),
                        Card(
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
                                        controller: _nameController,
                                        validator: (name) {
                                          return name.isNotEmpty
                                              ? null
                                              : 'Nama tidak boleh kosong';
                                        },
                                        decoration: _loginFormDecoration(
                                          context,
                                          hintText: 'Nama Lengkap',
                                          prefixIcon: FontAwesomeIcons.idBadge,
                                        ),
                                      ),
                                      SizedBox(height: 8),
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
                                      SizedBox(height: 8),
                                      TextFormField(
                                        obscureText: _hidePassword,
                                        validator: (password) {
                                          return password ==
                                                  _passwordController.text
                                              ? null
                                              : 'Password tidak sama';
                                        },
                                        decoration: _loginFormDecoration(
                                          context,
                                          hintText: 'Konfirmasi Password',
                                          prefixIcon:
                                              FontAwesomeIcons.unlockAlt,
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
                                      SizedBox(height: 12),
                                      TextButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            String _name =
                                                _nameController.text.trim();
                                            String _email =
                                                _emailController.text.trim();
                                            String _password =
                                                _passwordController.text.trim();

                                            auth.registerWithEmail(
                                              _name,
                                              _email,
                                              _password,
                                            );
                                          }
                                        },
                                        child: Text(
                                          'DAFTAR',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Theme.of(context).primaryColor,
                                          ),
                                          overlayColor:
                                              MaterialStateProperty.all(
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
                                          elevation:
                                              MaterialStateProperty.all(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
}
