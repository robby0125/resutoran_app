import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/presentation/pages/login_screen.dart';
import 'package:resutoran_app/core/presentation/provider/auth_provider.dart';
import 'package:resutoran_app/core/presentation/provider/restaurant_provider.dart';
import 'package:resutoran_app/util/helper.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) => Scaffold(
        appBar: AppBar(
          title: Text('Beranda'),
        ),
        drawer: Drawer(
          child: auth.user != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/drawer_header_bg.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withAlpha(150),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red,
                            backgroundImage: NetworkImage(
                              auth.user != null
                                  ? auth.user.photoUrl
                                  : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            auth.user != null
                                ? auth.user.displayName
                                : 'User Name',
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            auth.user != null ? auth.user.email : 'User Email',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.home,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text('Beranda'),
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.pinkAccent,
                      ),
                      title: Text('Favorit Saya'),
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.userCog,
                        color: Colors.lightBlue,
                      ),
                      title: Text('Pengaturan Profil'),
                    ),
                    Expanded(child: Material()),
                    Divider(thickness: 2),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.red,
                      ),
                      title: Text('Keluar'),
                    ),
                  ],
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withAlpha(150),
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        'images/auth_background.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum ada akun yang terhubung, silahkan masuk/daftar akun terlebih dahulu.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () =>
                                Get.toNamed(LoginScreen.routeName),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
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
                            ),
                            child: Text(
                              'Masuk',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
        body: StreamBuilder<List<RestaurantEntity>>(
          stream: Provider.of<RestaurantProvider>(context)
              .restaurantUseCase
              .getRestaurants(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<RestaurantModel> _restaurants = snapshot.data;

              return ListView.separated(
                itemBuilder: (context, index) {
                  return RestaurantItem(
                    restaurant: _restaurants[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 4);
                },
                itemCount: _restaurants.length,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              );
            }
          },
        ),
      ),
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
