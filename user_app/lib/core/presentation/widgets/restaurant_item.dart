import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/util/helper.dart';

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
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Colors.pink,
                    ),
                    SizedBox(width: 8),
                    FutureBuilder(
                      future: Helper.getCityFromLatLong(GeoPoint(
                        restaurant.latitude,
                        restaurant.longitude,
                      )),
                      builder: (context, snapshot) {
                        String _data = snapshot.data ?? 'Loading City...';
                        return Text(
                          _data,
                          style: Theme.of(context).textTheme.bodyText1,
                        );
                      },
                    ),
                    SizedBox(width: 24),
                    Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 8),
                    Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
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
