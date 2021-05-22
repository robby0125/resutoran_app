import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantEntity {
  final String name;
  final String description;
  final String pictures;
  final double rating;
  final GeoPoint location;
  final List<int> categoryIds;
  final List<Map<String, dynamic>> drinks;
  final List<Map<String, dynamic>> foods;
  final List<Map<String, dynamic>> reviews;

  RestaurantEntity({
    this.name,
    this.description,
    this.rating,
    this.location,
    this.categoryIds,
    this.drinks,
    this.foods,
    this.pictures,
    this.reviews,
  });
}
