import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';

abstract class FirestoreUseCase {
  Stream<List<RestaurantEntity>> getRestaurants();

  void addRegisteredUser(UserEntity userEntity);
}
