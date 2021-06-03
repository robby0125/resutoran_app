import 'package:flutter/foundation.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/usecases/restaurant_usecase.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantUseCase _restaurantUseCase;

  RestaurantProvider(this._restaurantUseCase);

  Stream<List<RestaurantModel>> streamRestaurants() =>
      _restaurantUseCase.getRestaurants();
}
