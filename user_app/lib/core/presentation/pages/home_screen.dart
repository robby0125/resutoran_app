import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/presentation/pages/detail_screen.dart';
import 'package:resutoran_app/core/presentation/pages/search_result_screen.dart';
import 'package:resutoran_app/core/presentation/pages/show_all_restaurant_screen.dart';
import 'package:resutoran_app/core/presentation/providers/firestore_provider.dart';
import 'package:resutoran_app/core/presentation/widgets/section_tile_with_show_all.dart';
import 'package:resutoran_app/util/helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _searchMode = false;
  List<RestaurantModel> _restaurants;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchMode
            ? TextFormField(
                autofocus: _searchMode,
                decoration: InputDecoration(
                  hintText: 'Temukan restoran favorit kamu...',
                ),
                style: Theme.of(context).textTheme.bodyText1,
                onFieldSubmitted: (query) => Get.toNamed(
                  SearchResultScreen.routeName,
                  arguments: SearchArguments(
                    restaurants: _restaurants,
                    query: query,
                  ),
                ),
              )
            : Text(
                'Beranda',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _searchMode ? FontAwesomeIcons.times : FontAwesomeIcons.search,
            ),
            onPressed: () {
              if (_restaurants != null) {
                setState(() {
                  _searchMode = !_searchMode;
                });
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Provider.of<FirestoreProvider>(context).streamRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _restaurants = snapshot.data;

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
                  SectionTileWithShowAll(
                      title: 'Restoran Populer',
                      onTap: () => Get.toNamed(
                            ShowAllRestaurantScreen.routeName,
                            arguments: ShowAllRestaurantArgs(
                              title: 'Restoran Populer',
                              restaurants: _sortByPopularity(),
                            ),
                          )),
                  _buildRestaurantList(_sortByPopularity()),
                  SectionTileWithShowAll(
                      title: 'Restoran Terdekat',
                      onTap: () => Get.toNamed(
                            ShowAllRestaurantScreen.routeName,
                            arguments: ShowAllRestaurantArgs(
                              title: 'Restoran Terdekat',
                              restaurants: _sortByDistance(),
                            ),
                          )),
                  _buildRestaurantList(_sortByDistance()),
                  SectionTileWithShowAll(
                      title: 'Restoran Lainnya',
                      onTap: () => Get.toNamed(
                            ShowAllRestaurantScreen.routeName,
                            arguments: ShowAllRestaurantArgs(
                              title: 'Restoran Lainnya',
                              restaurants: _restaurants,
                            ),
                          )),
                  _buildRestaurantList(_restaurants),
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

  List<RestaurantModel> _sortByPopularity() {
    List<RestaurantModel> _results = [];
    _results.addAll(_restaurants);
    _results.sort((a, b) => b.rating.compareTo(a.rating));
    return _results;
  }

  List<RestaurantModel> _sortByDistance() {
    var _pos = Helper.userPosition;
    List<RestaurantModel> _results = [];
    _results.addAll(_restaurants);
    _results.sort((a, b) {
      var _firstDistance = Geolocator.distanceBetween(
        _pos.latitude,
        _pos.longitude,
        a.latitude,
        a.longitude,
      );

      var _secondDistance = Geolocator.distanceBetween(
        _pos.latitude,
        _pos.longitude,
        b.latitude,
        b.longitude,
      );

      print('${a.name}: $_firstDistance m\n${b.name}: $_secondDistance m');

      return _firstDistance.compareTo(_secondDistance);
    });
    return _results;
  }

  Container _buildRestaurantList(List<RestaurantModel> _listRestaurant) {
    return Container(
      height: 196,
      child: ListView.separated(
        itemBuilder: (context, index) {
          var _restaurant = _listRestaurant[index];
          return MiniRestaurantCard(restaurant: _restaurant);
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 8);
        },
        itemCount: _listRestaurant.length > 1 ? _listRestaurant.length : 1,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
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
