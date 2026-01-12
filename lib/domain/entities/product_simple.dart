class Variant {
  final String id;
  final String name;
  final String hexColor;
  final double price;
  final String? sku;
  final int stock;
  final bool isAvailable;

  const Variant({
    required this.id,
    required this.name,
    required this.hexColor,
    required this.price,
    this.sku,
    this.stock = 0,
    this.isAvailable = true,
  });
}

class Product {
  final String id;
  final String vendorId;
  final String name;
  final String brand;
  final String finish;
  final double price;
  final String? description;
  final List<String> images;
  final List<Variant> variants;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final bool isSponsored;
  final bool isAvailable;
  final int viewCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.brand,
    required this.finish,
    required this.price,
    this.description,
    this.images = const [],
    this.variants = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.tags = const [],
    this.isSponsored = false,
    this.isAvailable = true,
    this.viewCount = 0,
    this.createdAt,
    this.updatedAt,
  });
}