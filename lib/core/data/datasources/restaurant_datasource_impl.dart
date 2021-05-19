import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resutoran_app/core/data/datasources/restaurant_datasource.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';

class RestaurantDataSourceImpl implements RestaurantDataSource {
  final FirebaseFirestore _firestore;

  RestaurantDataSourceImpl(this._firestore);

  @override
  Stream<List<RestaurantEntity>> getAllRestaurants() {
    final _restaurantCollectionRef = _firestore.collection('restaurants');
    return _restaurantCollectionRef.snapshots().map((event) {
      return event.docs.map((e) {
        return RestaurantModel.fromSnapshot(e);
      }).toList();
    });
  }
}
