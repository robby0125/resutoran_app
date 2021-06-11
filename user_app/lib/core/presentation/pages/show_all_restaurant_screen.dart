import 'package:flutter/material.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/presentation/widgets/restaurant_item.dart';

class ShowAllRestaurantScreen extends StatelessWidget {
  static const routeName = '/show_all_restaurant';

  final ShowAllRestaurantArgs args;

  ShowAllRestaurantScreen({@required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.title,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            var _restaurant = args.restaurants[index];

            return RestaurantItem(
              restaurant: _restaurant,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
          itemCount: args.restaurants.length,
        ),
      ),
    );
  }
}

class ShowAllRestaurantArgs {
  final String title;
  final List<RestaurantModel> restaurants;

  ShowAllRestaurantArgs({
    @required this.title,
    @required this.restaurants,
  });
}
