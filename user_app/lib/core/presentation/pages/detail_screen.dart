import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/presentation/pages/all_review_screen.dart';
import 'package:resutoran_app/core/presentation/widgets/review_item.dart';
import 'package:resutoran_app/core/presentation/widgets/section_tile_with_show_all.dart';
import 'package:resutoran_app/util/helper.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final RestaurantModel restaurant;

  DetailScreen({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detil Restoran',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.heart,
              color: Colors.pink,
            ),
            onPressed: () {
              if (!Get.isSnackbarOpen) {
                Get.rawSnackbar(message: 'Coming Soon!');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              restaurant.pictures,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      restaurant.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Colors.red,
                        ),
                        FutureBuilder(
                          future: Helper.getFullAddressFromLatLong(GeoPoint(
                            restaurant.latitude,
                            restaurant.longitude,
                          )),
                          builder: (context, snapshot) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              snapshot.data ?? 'Loading Address..',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.black87),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(width: 8),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 24,
                  ),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Divider(
                    thickness: 2,
                    height: 24,
                  ),
                  Text(
                    'Daftar Menu',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Makanan',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 155,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> _food = restaurant.foods[index];

                        return _buildMenuItem(
                          context,
                          photoUrl: _food['picture'],
                          itemName: _food['name'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8);
                      },
                      itemCount: restaurant.foods.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Minuman',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 155,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> _drink = restaurant.drinks[index];

                        return _buildMenuItem(
                          context,
                          photoUrl: _drink['picture'],
                          itemName: _drink['name'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8);
                      },
                      itemCount: restaurant.drinks.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 24,
                  ),
                  SectionTileWithShowAll(
                    title: 'Ulasan',
                    onTap: () => Get.toNamed(
                      AllReviewScreen.routeName,
                      arguments: AllReviewArgs(
                        restaurantName: restaurant.name,
                        reviews: restaurant.reviews,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        restaurant.reviews.length > 3
                            ? 3
                            : restaurant.reviews.length, (index) {
                      Map<String, dynamic> _review = restaurant.reviews[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: index < 2 ? 8 : 0),
                        child: ReviewItem(
                          photoUrl: _review['photoUrl'],
                          userName: _review['displayName'],
                          userReview: _review['review'],
                          rating: _review['rate'],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    @required String photoUrl,
    @required String itemName,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: 200,
        child: Column(
          children: [
            Image.network(
              photoUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 4),
            Text(
              itemName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
