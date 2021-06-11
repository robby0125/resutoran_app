import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';
import 'package:resutoran_app/core/domain/repositories/firestore_repository.dart';
import 'package:resutoran_app/core/domain/usecases/firestore_usecase.dart';

class FirestoreInteractor implements FirestoreUseCase {
  final FirestoreRepository _firestoreRepository;

  FirestoreInteractor(this._firestoreRepository);

  @override
  Stream<List<RestaurantEntity>> getRestaurants() =>
      _firestoreRepository.getAllRestaurants();

  @override
  void addRegisteredUser(UserEntity userEntity) =>
      _firestoreRepository.addRegisteredUser(userEntity);
}
