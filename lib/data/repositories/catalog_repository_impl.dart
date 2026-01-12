import 'package:gloss_bloom/domain/entities/product.dart';
import 'package:gloss_bloom/domain/entities/vendor.dart';
import 'package:gloss_bloom/domain/repositories/catalog_repository.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  @override
  Future<List<Product>> getProducts({
    ProductFilters? filters,
    SortBy sortBy = SortBy.relevance,
    int page = 0,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.demoMode) {
      // Return empty list with shimmer placeholders handled by UI
      return [];
    }
    
    return [];
  }

  @override
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return null; // Empty state handled by UI
  }

  @override
  Future<List<Product>> getSponsoredProducts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [];
  }

  @override
  Future<List<Product>> getTrendingProducts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [];
  }

  @override
  Future<List<Product>> getNewProducts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [];
  }

  @override
  Future<List<Vendor>> getVendors({
    String? searchQuery,
    String? city,
    int page = 0,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<Vendor?> getVendorById(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return null;
  }

  @override
  Future<List<Product>> getProductsByVendor(String vendorId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<String>> getBrands() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppConstants.demoMode 
      ? ['Fenty Beauty', 'Rare Beauty', 'Glossier', 'Charlotte Tilbury']
      : [];
  }

  @override
  Future<List<String>> getFinishes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppConstants.demoMode 
      ? ['Matte', 'Glossy', 'Satin', 'Metallic']
      : [];
  }

  @override
  Future<List<String>> getColors() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppConstants.demoMode 
      ? ['Rouge', 'Rose', 'Nude', 'Corail', 'Bordeaux']
      : [];
  }
}