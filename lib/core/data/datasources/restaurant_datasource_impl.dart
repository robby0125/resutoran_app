import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resutoran_app/core/data/datasources/restaurant_datasource.dart';
import 'package:resutoran_app/core/data/models/restaurant_model.dart';

class RestaurantDataSourceImpl implements RestaurantDataSource {
  final FirebaseFirestore _firestore;

  RestaurantDataSourceImpl(this._firestore);

  @override
  Stream<List<RestaurantModel>> getAllRestaurants() {
    final _restaurantCollectionRef = _firestore.collection('restaurants');
    return _restaurantCollectionRef.snapshots().map((event) {
      return event.docs.map((e) {
        return RestaurantModel.fromSnapshot(e);
      }).toList();
    });
  }
}
