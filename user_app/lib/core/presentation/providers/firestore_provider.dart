import 'package:flutter/foundation.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/usecases/firestore_usecase.dart';

class FirestoreProvider extends ChangeNotifier {
  final FirestoreUseCase _restaurantUseCase;

  FirestoreProvider(this._restaurantUseCase);

  Stream<List<RestaurantModel>> streamRestaurants() =>
      _restaurantUseCase.getRestaurants();
}
