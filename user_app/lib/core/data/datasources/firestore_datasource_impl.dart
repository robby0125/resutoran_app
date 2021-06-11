import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resutoran_app/core/data/datasources/firestore_datasource.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/entities/user_entity.dart';

class FirestoreDataSourceImpl implements FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSourceImpl(this._firestore);

  @override
  Stream<List<RestaurantModel>> getAllRestaurants() {
    final _restaurantCollectionRef = _firestore.collection('restaurants');
    return _restaurantCollectionRef.snapshots().map((event) {
      return event.docs.map((e) {
        return RestaurantModel.fromSnapshot(e);
      }).toList();
    });
  }

  @override
  void addRegisteredUser(UserEntity userEntity) {
    _firestore.collection('users')
      ..doc(userEntity.uid).set({
        'displayName': userEntity.displayName,
        'email': userEntity.email,
        'photoUrl': userEntity.photoUrl,
      });
  }
}
