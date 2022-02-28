import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/network/dio_network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  final DioNetworkUtil _dio;

  ProductRepository(this._dio);

  Future<Response> categories(bool refresh) => _dio.get(
        "index.php?route=custom/category",
        options: buildCacheOptions(
          Duration(days: 1),
          forceRefresh: refresh,
        ),
      );

  Future<Response> subCategories(categoryId, bool refresh) => _dio.get(
        "index.php?route=custom/category/getSubCategory",
        params: {
          'level': 1,
          'parent_id': categoryId,
        },
      );

  Future<Response> productsByCategory(String categoryCode) => _dio.get(
        "index.php?route=api/allproducts/categoryList",
        params: {
          "json": "",
          "path": categoryCode,
        },
        options: buildCacheOptions(
          Duration(days: 2),
        ),
      );

  Future<Response> productsByCategoryWithPage(
    String categoryId,
    String subCategoryId,
    int page,
  ) {
    return _dio.get(
      'index.php?route=custom/product/search',
      params: subCategoryId.isEmpty
          ? {
              'page': page,
              'category': categoryId,
              'sub_category': categoryId,
              'limit': 15,
              'order': 'ASC',
            }
          : {
              'sub_category': subCategoryId,
              'page': page,
              'category': categoryId,
              'limit': 15,
              'order': 'ASC',
            },
    );
  }

  Future<Response> productDetails(String productId) => _dio.get(
        "index.php?route=custom/product/getProduct",
        params: {
          "product_id": productId,
        },
      );

  Future<Response> similarProducts(String productId) => _dio.get(
        "index.php?route=custom/product/getRelatedProduct",
        params: {
          "product_id": productId,
        },
      );

  Future<Response> addProductToCart(int quantity, String productId) =>
      _dio.postForm(
        'index.php?route=custom/cart/add',
        FormData.fromMap({
          'product_id': productId,
          'quantity': quantity,
        }),
      );

  Future<Response> getBanners(bool refresh) =>
      _dio.get("index.php?route=custom/banner");

  Future<Response> search(
    searchQuery,
    String sortWithOrder,
    String categoryId,
    String subCategoryId,
  ) =>
      _dio.get(
        'index.php?route=custom/product/search&$sortWithOrder}',
        params: {
          'limit': 15,
          'search': searchQuery,
          'page': 0,
          'manufacturer': null,
          'category': categoryId,
          'sub_category': subCategoryId,
          'description': null,
          'tag': null,
        },
        options: buildCacheOptions(
          Duration(seconds: 10),
        ),
      );

  Future<Response> getBestSellerProducts(bool refresh) => _dio.get(
        'index.php?route=custom/product/getBestProducts',
        params: {'limit': 15},
      );

  Future<Response> getPopularProducts(bool refresh) => _dio.get(
        'index.php?route=custom/product/getPopularProducts',
        params: {'limit': 15},
      );

  Future<Response> getLatestProducts(bool refresh) => _dio.get(
        'index.php?route=custom/product/getLatestProducts',
        params: {'limit': 15},
      );

  Future<Response> productReviews(String productId) => _dio.get(
        "index.php?route=custom/product/getProductReview",
        params: {
          "product_id": productId,
        },
      );

  Future<Response> addProductReview(
    String productId,
    String review,
    double rating,
    String author,
  ) =>
      _dio.postForm(
        "index.php?route=custom/product/setProductReview",
        FormData.fromMap({
          'product_id': productId,
          'author': author,
          'text': review,
          'rating': rating,
        }),
      );

  Future<Response> add(String productId) => _dio.postForm(
        "index.php?route=custom/wishlist/add",
        FormData.fromMap({
          'product_id': productId,
        }),
      );

  Future<Response> delete(String productId) => _dio.deleteForm(
        "index.php?route=custom/wishlist/delete",
        FormData.fromMap({
          'product_id': productId,
        }),
      );

  Future<Response> wishListProducts() => _dio.get(
        'index.php?route=custom/wishlist',
      );

  Future<Response> productComparison() async {
    final prefs = await SharedPreferences.getInstance();
    final productIds = prefs.getStringList(productComparisonList) ?? [];
    return _dio.get(
      "index.php?route=custom/product/compare",
      params: {
        'product_ids': productIds.join(','),
      },
    );
  }

  Future<String> socialLinks() async {
    return await rootBundle.loadString("assets/social_links.json");
  }

  Future<Response> categoryDetails(String categoryId) {
    return _dio.get(
      "index.php?route=custom/category",
      params: {
        'level': 0,
        'category_id': categoryId,
      },
    );
  }

  Future<Response> addToWishlist(String productId) => _dio.postForm(
        'index.php?route=custom/wishlist/add',
        FormData.fromMap({
          'product_id': productId,
        }),
      );

  Future<Response> removeFromWishlist(String productId) => _dio.delete(
        'index.php?route=custom/wishlist/delete',
        params: {
          'product_id': productId,
        },
      );
}
