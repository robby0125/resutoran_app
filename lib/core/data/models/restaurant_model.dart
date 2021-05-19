import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  RestaurantModel({
    String name,
    String description,
    double rating,
    GeoPoint location,
    List<int> categoryIds,
    List<Map<String, dynamic>> drinks,
    List<Map<String, dynamic>> foods,
    List<String> pictures,
    List<Map<String, dynamic>> reviews,
  }) : super(
          name: name,
          description: description,
          rating: rating,
          location: location,
          categoryIds: categoryIds,
          drinks: drinks,
          foods: foods,
          pictures: pictures,
          reviews: reviews,
        );

  factory RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) =>
      RestaurantModel(
        name: snapshot['name'],
        description: snapshot['description'],
        rating: snapshot['rating'].toDouble(),
        location: snapshot['location'],
        categoryIds: List.from(snapshot['category']),
        drinks: List.from(snapshot['menu']['drinks']),
        foods: List.from(snapshot['menu']['foods']),
        pictures: List.from(snapshot['pictures']),
        reviews: List.from(snapshot['reviews']),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'rating': rating,
        'location': location,
        'category': categoryIds,
        'menu': {
          'drinks': drinks,
          'foods': foods,
        },
        'pictures': pictures,
        'reviews': reviews,
      };
}
