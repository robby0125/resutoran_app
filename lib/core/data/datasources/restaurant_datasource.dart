import 'package:resutoran_app/core/data/models/restaurant_model.dart';

abstract class RestaurantDataSource {
  Stream<List<RestaurantModel>> getAllRestaurants();
}
