import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';

abstract class RestaurantUseCase {
  Stream<List<RestaurantEntity>> getRestaurants();
}
