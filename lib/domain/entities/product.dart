import 'package:gloss_bloom/domain/entities/variant.dart';

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      vendorId: json['vendorId'],
      name: json['name'],
      brand: json['brand'],
      finish: json['finish'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      images: List<String>.from(json['images'] ?? []),
      variants: (json['variants'] as List? ?? [])
        .map((variant) => Variant.fromJson(variant)).toList(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      isSponsored: json['isSponsored'] ?? false,
      isAvailable: json['isAvailable'] ?? true,
      viewCount: json['viewCount'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'name': name,
      'brand': brand,
      'finish': finish,
      'price': price,
      'description': description,
      'images': images,
      'variants': variants.map((variant) => variant.toJson()).toList(),
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'isSponsored': isSponsored,
      'isAvailable': isAvailable,
      'viewCount': viewCount,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}