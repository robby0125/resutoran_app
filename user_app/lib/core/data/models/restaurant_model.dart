import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resutoran_app/core/domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  final String name;
  final String description;
  final String pictures;
  final double rating;
  final double latitude;
  final double longitude;
  final List<Map<String, dynamic>> drinks;
  final List<Map<String, dynamic>> foods;
  final List<Map<String, dynamic>> reviews;

  RestaurantModel({
    this.name,
    this.description,
    this.pictures,
    this.rating,
    this.latitude,
    this.longitude,
    this.drinks,
    this.foods,
    this.reviews,
  }) : super(
          name: name,
          description: description,
          pictures: pictures,
          rating: rating,
          latitude: latitude,
          longitude: longitude,
          drinks: drinks,
          foods: foods,
          reviews: reviews,
        );

  factory RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) =>
      RestaurantModel(
        name: snapshot['name'],
        description: snapshot['description'],
        pictures: snapshot['picture'],
        rating: snapshot['rating'].toDouble(),
        latitude: (snapshot['location'] as GeoPoint).latitude,
        longitude: (snapshot['location'] as GeoPoint).longitude,
        drinks: List.from(snapshot['menu']['drinks']),
        foods: List.from(snapshot['menu']['foods']),
        reviews: List.from(snapshot['reviews']),
      );
}
