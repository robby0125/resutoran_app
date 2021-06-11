abstract class RestaurantEntity {
  final String name;
  final String description;
  final String pictures;
  final double rating;
  final double latitude;
  final double longitude;
  final List<Map<String, dynamic>> drinks;
  final List<Map<String, dynamic>> foods;
  final List<Map<String, dynamic>> reviews;

  RestaurantEntity({
    this.name,
    this.description,
    this.pictures,
    this.rating,
    this.latitude,
    this.longitude,
    this.drinks,
    this.foods,
    this.reviews,
  });
}
