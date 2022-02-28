import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/model/sub_category.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/locator.dart';
import 'package:rxdart/rxdart.dart';

class ProductModel {
  final Repository _repository = locator<Repository>();
  final StreamController<bool> _loadingController = BehaviorSubject<bool>();
  final StreamController<int> _maxCount = BehaviorSubject<int>();
  final SubCategory _subCategory;

  Stream<bool> get isLoading => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;

  Stream<int> get maxCount => _maxCount.stream;
  int pageNumber = 1;
  double pixels = 0.0;

  void dispose() {
    _loadingController.close();
    _controller.close();
    _subject.close();
    _maxCount.close();
  }

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();
  final ReplaySubject<List<Product>> _subject = ReplaySubject();

  Stream<List<Product>> get productListStream => _subject.stream;

  Sink<ScrollNotification> get sink => _controller.sink;

  ProductModel(this._subCategory) {
    _subject.addStream(
      Stream.fromFuture(
        getProductsByCategoryWithPage(),
      ),
    );

    _controller.listen(
      (notification) => getProductsByCategory(notification),
      onError: (error) {
        print(error.toString());
      },
    );
  }

  Future<void> getProductsByCategory(
    ScrollNotification notification,
  ) async {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;
      try {
        isLoadingSink.add(true);
        pageNumber++;
        final result = await _repository.productsByCategoryWithPage(
          _subCategory.categoryId,
          _subCategory.subCategory.categoryId,
          pageNumber,
        );
        var popularProducts = productFromJson(result.data).success.products;
        if (popularProducts.isNotEmpty) {
          _subject.sink.add(popularProducts);
        }
        isLoadingSink.add(false);
      } catch (error) {
        print(error.toString());
        isLoadingSink.add(false);
      }
    }
  }

  Future<List<Product>> getProductsByCategoryWithPage() async {
    try {
      final result = await _repository.productsByCategoryWithPage(
        _subCategory.categoryId,
        _subCategory.subCategory.categoryId,
        pageNumber,
      );
      var productResponse = productFromJson(result.data);
      _maxCount.add(int.parse(productResponse.success.totalProducts));
      var popularProducts = productResponse.success.products;
      if (popularProducts.isNotEmpty) {
        return popularProducts;
      } else {
        return [];
      }
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
