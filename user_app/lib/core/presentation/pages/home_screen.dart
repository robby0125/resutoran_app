import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/presentation/pages/detail_screen.dart';
import 'package:resutoran_app/core/presentation/provider/restaurant_provider.dart';
import 'package:resutoran_app/util/helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beranda',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Provider.of<RestaurantProvider>(context)
            .restaurantUseCase
            .getRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RestaurantModel> _listRestaurant = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: double.infinity,
                    height: 280,
                    child: Image.asset(
                      'images/drawer_header_bg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Restoran Populer',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      'Lihat Semua',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    height: 196,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var _restaurant = _listRestaurant[index];
                        return MiniRestaurantCard(restaurant: _restaurant);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8);
                      },
                      itemCount: _listRestaurant.length > 1
                          ? _listRestaurant.length
                          : 1,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Restoran Terdekat',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      'Lihat Semua',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    height: 196,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var _restaurant = _listRestaurant[index];
                        return MiniRestaurantCard(restaurant: _restaurant);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8);
                      },
                      itemCount: _listRestaurant.length > 1
                          ? _listRestaurant.length
                          : 1,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(
                size: 60,
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}

class MiniRestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  MiniRestaurantCard({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        DetailScreen.routeName,
        arguments: restaurant,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                restaurant.pictures,
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  restaurant.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              FutureBuilder(
                future: Helper.getCityFromLatLong(GeoPoint(
                  restaurant.latitude,
                  restaurant.longitude,
                )),
                builder: (context, snapshot) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    snapshot.data ?? 'Loading City',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
