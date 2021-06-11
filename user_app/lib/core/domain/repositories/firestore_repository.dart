import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';

abstract class FirestoreRepository {
  Stream<List<RestaurantEntity>> getAllRestaurants();

  void addRegisteredUser(UserEntity userEntity);
}
