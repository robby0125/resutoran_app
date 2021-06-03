import 'package:flutter/material.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/presentation/widgets/restaurant_item.dart';

class SearchResultScreen extends StatefulWidget {
  static const routeName = '/search_result';

  final SearchArguments args;

  SearchResultScreen({@required this.args});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<RestaurantModel> _restaurantResults = [];

  @override
  void initState() {
    super.initState();

    print(widget.args.query);

    widget.args.restaurants.forEach((restaurant) {
      if (restaurant.name.toLowerCase().contains(widget.args.query)) {
        _restaurantResults.add(restaurant);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Pencarian',
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
            var _restaurant = _restaurantResults[index];

            return RestaurantItem(
              restaurant: _restaurant,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
          itemCount: _restaurantResults.length,
        ),
      ),
    );
  }
}

class SearchArguments {
  final List<RestaurantModel> restaurants;
  final String query;

  SearchArguments({
    @required this.restaurants,
    @required this.query,
  });
}
