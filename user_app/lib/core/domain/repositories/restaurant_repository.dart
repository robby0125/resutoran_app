import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';

abstract class RestaurantRepository {
  Stream<List<RestaurantEntity>> getAllRestaurants();
}
