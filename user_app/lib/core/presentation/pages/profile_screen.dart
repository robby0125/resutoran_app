import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/presentation/pages/login_screen.dart';
import 'package:resutoran_app/core/presentation/provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Profil',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          width: double.infinity,
          child: auth.user != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(auth.user.photoUrl),
                    ),
                    SizedBox(height: 16),
                    Text(
                      auth.user.displayName,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      auth.user.email,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 32),
                    _buildProfileMenuTile(
                      context,
                      title: 'Ubah Nama',
                      icon: FontAwesomeIcons.userEdit,
                      enableArrow: true,
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    _buildProfileMenuTile(
                      context,
                      title: 'Ubah Password',
                      icon: FontAwesomeIcons.unlock,
                      enableArrow: true,
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    _buildProfileMenuTile(
                      context,
                      title: 'Keluar',
                      icon: FontAwesomeIcons.signOutAlt,
                      enableArrow: false,
                      onTap: () => auth.signOut(),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum ada akun terhubung, silahkan masuk/daftar terlebih dahulu!',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Get.toNamed(LoginScreen.routeName),
                      child: Text(
                        'Masuk',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProfileMenuTile(
    BuildContext context, {
    @required String title,
    @required IconData icon,
    @required bool enableArrow,
    @required Function onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: [
            FaIcon(icon),
            SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Expanded(child: Material()),
            enableArrow ? FaIcon(FontAwesomeIcons.chevronRight) : Material(),
          ],
        ),
      ),
    );
  }
}
