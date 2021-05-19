import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';

abstract class RestaurantDataSource {
  Stream<List<RestaurantEntity>> getAllRestaurants();
}
