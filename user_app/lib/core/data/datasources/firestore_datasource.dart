import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';

abstract class FirestoreDataSource {
  Stream<List<RestaurantModel>> getAllRestaurants();

  void addRegisteredUser(UserEntity userEntity);
}
