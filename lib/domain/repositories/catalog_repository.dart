import 'package:gloss_bloom/domain/entities/product.dart';
import 'package:gloss_bloom/domain/entities/vendor.dart';

enum SortBy {
  relevance,
  priceAsc,
  priceDesc,
  newest,
  rating,
}

class ProductFilters {
  final String? searchQuery;
  final double? minPrice;
  final double? maxPrice;
  final List<String>? colors;
  final List<String>? finishes;
  final List<String>? brands;
  final List<String>? vendorIds;
  final double? minRating;
  final int? maxDeliveryDays;
  final bool? isSponsored;

  const ProductFilters({
    this.searchQuery,
    this.minPrice,
    this.maxPrice,
    this.colors,
    this.finishes,
    this.brands,
    this.vendorIds,
    this.minRating,
    this.maxDeliveryDays,
    this.isSponsored,
  });
}

abstract class CatalogRepository {
  Future<List<Product>> getProducts({
    ProductFilters? filters,
    SortBy sortBy = SortBy.relevance,
    int page = 0,
    int pageSize = 20,
  });
  
  Future<Product?> getProductById(String id);
  
  Future<List<Product>> getSponsoredProducts();
  
  Future<List<Product>> getTrendingProducts();
  
  Future<List<Product>> getNewProducts();
  
  Future<List<Vendor>> getVendors({
    String? searchQuery,
    String? city,
    int page = 0,
    int pageSize = 20,
  });
  
  Future<Vendor?> getVendorById(String id);
  
  Future<List<Product>> getProductsByVendor(String vendorId);
  
  Future<List<String>> getBrands();
  
  Future<List<String>> getFinishes();
  
  Future<List<String>> getColors();
}