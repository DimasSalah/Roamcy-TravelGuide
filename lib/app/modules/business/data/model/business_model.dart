class BusinessModel {
  final String id;
  final String name;
  final String description;
  final String link;
  final String imageLink;
  final DateTime? createdAt;

  BusinessModel({
    required this.id,
    required this.name,
    required this.description,
    required this.link,
    required this.imageLink,
    this.createdAt,
  });

  // Factory constructor to create object from Firestore document
  factory BusinessModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BusinessModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      link: data['link'] ?? '',
      imageLink: data['image_link'] ?? '',
      createdAt: data['created_at']?.toDate(),
    );
  }

  // Method to convert object to Map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'link': link,
      'image_link': imageLink,
      'created_at': createdAt,
    };
  }
}
