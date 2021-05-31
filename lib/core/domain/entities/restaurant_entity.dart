abstract class RestaurantEntity {
  String get name;

  String get description;

  String get pictures;

  double get rating;

  double get latitude;

  double get longitude;

  List<int> get categoryIds;

  List<Map<String, dynamic>> get drinks;

  List<Map<String, dynamic>> get foods;

  List<Map<String, dynamic>> get reviews;
}
