import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/presentation/pages/home_screen.dart';
import 'package:resutoran_app/core/presentation/pages/profile_screen.dart';
import 'package:resutoran_app/core/presentation/providers/auth_provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: PersistentTabView(
              context,
              screens: [
                HomeScreen(),
                Center(
                  child: Text(
                    'Coming Soon!',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                ProfileScreen(),
              ],
              items: [
                PersistentBottomNavBarItem(
                  icon: FaIcon(FontAwesomeIcons.home),
                  title: 'Beranda',
                  activeColorPrimary: Theme.of(context).primaryColor,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidHeart),
                  title: 'Favorit',
                  activeColorPrimary: Colors.pinkAccent,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  title: 'Profil',
                  activeColorPrimary: Colors.lightBlue,
                  inactiveColorPrimary: Colors.grey,
                ),
              ],
              resizeToAvoidBottomInset: false,
              handleAndroidBackButtonPress: true,
              hideNavigationBarWhenKeyboardShows: true,
              navBarStyle: NavBarStyle.style13,
            ),
          ),
        );
      },
    );
  }
}
