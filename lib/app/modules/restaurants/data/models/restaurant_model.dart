class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String mapsLink;
  final double latitude;
  final double longitude;
  final double rating;
  final List<String> imageLinks;
  final DateTime? createdAt;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.mapsLink,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.imageLinks,
    this.createdAt,
  });

  factory RestaurantModel.fromFirestore(Map<String, dynamic> data, String id) {
    return RestaurantModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      mapsLink: data['mapsLink'] ?? '',
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      imageLinks: List<String>.from(data['imageLinks'] ?? []),
      createdAt: data['created_at']?.toDate(),
    );
  }
}
