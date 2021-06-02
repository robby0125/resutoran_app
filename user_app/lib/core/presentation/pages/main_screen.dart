import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/presentation/pages/home_screen.dart';
import 'package:resutoran_app/core/presentation/pages/profile_screen.dart';
import 'package:resutoran_app/core/presentation/provider/auth_provider.dart';
import 'package:resutoran_app/util/helper.dart';

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

class RestaurantItem extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantItem({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            restaurant.pictures,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          ListTile(
            minVerticalPadding: 8,
            title: Text(
              restaurant.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on),
                    FutureBuilder(
                      future: Helper.getCityFromLatLong(GeoPoint(
                        restaurant.latitude,
                        restaurant.longitude,
                      )),
                      builder: (context, snapshot) {
                        String _data = snapshot.data ?? 'Loading City...';
                        return Text(_data);
                      },
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.star_rate_rounded),
                    Text(restaurant.rating.toString()),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
          ),
        ],
      ),
    );
  }
}
