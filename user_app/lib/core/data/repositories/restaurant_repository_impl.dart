import 'package:resutoran_app/core/data/datasources/restaurant_datasource.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantDataSource _restaurantDataSource;

  RestaurantRepositoryImpl(this._restaurantDataSource);

  @override
  Stream<List<RestaurantEntity>> getAllRestaurants() =>
      _restaurantDataSource.getAllRestaurants();
}
