import 'package:resutoran_app/core/data/datasources/firestore_datasource.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';
import 'package:resutoran_app/core/domain/repositories/firestore_repository.dart';

class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirestoreDataSource _firestoreDataSource;

  FirestoreRepositoryImpl(this._firestoreDataSource);

  @override
  Stream<List<RestaurantEntity>> getAllRestaurants() =>
      _firestoreDataSource.getAllRestaurants();

  @override
  void addRegisteredUser(userEntity) =>
      _firestoreDataSource.addRegisteredUser(userEntity);
}
