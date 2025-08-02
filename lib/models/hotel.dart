class Hotel {
  final String id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final List<String> amenities;
  final double pricePerNight;
  final String currency;
  final bool isAvailable;
  final String category;
  final int starRating;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.amenities,
    required this.pricePerNight,
    required this.currency,
    required this.isAvailable,
    required this.category,
    required this.starRating,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      rating: json['rating'].toDouble(),
      reviewCount: json['review_count'],
      images: List<String>.from(json['images']),
      amenities: List<String>.from(json['amenities']),
      pricePerNight: json['price_per_night'].toDouble(),
      currency: json['currency'],
      isAvailable: json['is_available'],
      category: json['category'],
      starRating: json['star_rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'review_count': reviewCount,
      'images': images,
      'amenities': amenities,
      'price_per_night': pricePerNight,
      'currency': currency,
      'is_available': isAvailable,
      'category': category,
      'star_rating': starRating,
    };
  }

  Hotel copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    double? rating,
    int? reviewCount,
    List<String>? images,
    List<String>? amenities,
    double? pricePerNight,
    String? currency,
    bool? isAvailable,
    String? category,
    int? starRating,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      images: images ?? this.images,
      amenities: amenities ?? this.amenities,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      currency: currency ?? this.currency,
      isAvailable: isAvailable ?? this.isAvailable,
      category: category ?? this.category,
      starRating: starRating ?? this.starRating,
    );
  }
}