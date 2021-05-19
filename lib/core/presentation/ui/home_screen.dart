import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/presentation/provider/restaurant_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
            // List<Restaurant> _restaurants = snapshot.core.data.docs
            //     .map((e) => Restaurant.fromJson(e.core.data()))
            //     .toList();

            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                (snapshot.data.first as RestaurantModel).toMap().toString().replaceAll(', ', '\n'),
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
        },
      ),
    );
  }
}

class RestaurantItem extends StatelessWidget {
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
          Container(
            height: 200,
            color: Colors.grey,
          ),
          ListTile(
            minVerticalPadding: 8,
            title: Text(
              'Restaurant Name',
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'Restaurant Description',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on),
                    Text('City'),
                    SizedBox(width: 16),
                    Icon(Icons.star_rate_rounded),
                    Text('5.0'),
                  ],
                ),
              ],
            ),
            trailing: Container(
              height: double.infinity,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite),
              ),
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
