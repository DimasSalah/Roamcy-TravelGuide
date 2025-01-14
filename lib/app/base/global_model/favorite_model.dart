class FavoriteModel {
  final String id;
  final String name;
  final double rating;
  final List<String> imageUrls;
  final String mapsLink;
  final String description;
  final String activity;
  final DateTime addedAt;
  final double latitude;
  final double longitude;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrls,
    required this.mapsLink,
    required this.description,
    required this.activity,
    required this.addedAt,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'imageUrls': imageUrls,
      'mapsLink': mapsLink,
      'description': description,
      'activity': activity,
      'addedAt': addedAt.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      imageUrls: List<String>.from(json['imageUrls']),
      mapsLink: json['mapsLink'],
      description: json['description'],
      activity: json['activity'],
      addedAt: DateTime.parse(json['addedAt']),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
