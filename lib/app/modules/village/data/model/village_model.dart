class VillageModel {
  final String id;
  final String name;
  final String mapsLink;
  final double latitude;
  final double longitude;
  final List<String> imageLinks;
  final double rating;
  final String description;
  final DateTime? createdAt;

  VillageModel({
    required this.id,
    required this.name,
    required this.mapsLink,
    required this.latitude,
    required this.longitude,
    required this.imageLinks,
    required this.rating,
    required this.description,
    this.createdAt,
  });

  factory VillageModel.fromFirestore(Map<String, dynamic> data, String id) {
    return VillageModel(
      id: id,
      name: data['name'] ?? '',
      mapsLink: data['mapsLink'] ?? '',
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      imageLinks: List<String>.from(data['imageLink'] ?? []),
      rating: (data['rating'] ?? 0.0).toDouble(),
      description: data['description'] ?? '',
      createdAt: data['created_at']?.toDate(),
    );
  }

  @override
  String toString() {
    return 'VillageModel(id: $id, name: $name, mapsLink: $mapsLink, latitude: $latitude, longitude: $longitude, imageLinks: $imageLinks, rating: $rating, description: $description, createdAt: $createdAt)';
  }
}
