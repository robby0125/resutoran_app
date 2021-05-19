import 'package:flutter/foundation.dart';
import 'package:resutoran_app/core/domain/usecases/restaurant_usecase.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantUseCase _restaurantUseCase;

  RestaurantUseCase get restaurantUseCase => _restaurantUseCase;

  RestaurantProvider(this._restaurantUseCase);
}
