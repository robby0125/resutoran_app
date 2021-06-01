import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/domain/repositories/restaurant_repository.dart';
import 'package:resutoran_app/core/domain/usecases/restaurant_usecase.dart';

class RestaurantInteractor implements RestaurantUseCase {
  final RestaurantRepository _repository;

  RestaurantInteractor(this._repository);

  @override
  Stream<List<RestaurantEntity>> getRestaurants() =>
      _repository.getAllRestaurants();
}
