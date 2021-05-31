import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/presentation/pages/user_login_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              print(Get.locale);
              Get.toNamed(UserLoginScreen.routeName);
            },
          ),
        ],
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
