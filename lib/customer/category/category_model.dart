import 'dart:async';

import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/model/category_response.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/model/sub_category.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:grand_uae/locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_services/stacked_services.dart';

class CategoryModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Repository _repository = locator<Repository>();
  final StreamController<int> _maxCount = BehaviorSubject<int>();
  final String _categoryId;
  Category _category;

  Category get category => _category;

  set category(Category value) {
    _category = value;
    notifyListeners();
  }

  PagewiseLoadController pageLoadController = PagewiseLoadController(
    pageFuture: (int pageIndex) {
      return Future.value();
    },
    pageSize: 15,
  );
  List<Category> _subCategory = [];
  String _subCategoryId = "";
  int pageNumber = 1;
  double pixels = 0.0;
  Category _selectedChip;

  Category get selectedChip => _selectedChip;

  set selectedChip(Category value) {
    _selectedChip = value;
    notifyListeners();
  }

  Stream<int> get maxCount => _maxCount.stream;

  set setSelectedChip(Category category) {
    _subCategoryId = category.categoryId;
  }

  List<Category> get subCategories => _subCategory;

  set subCategories(List<Category> value) {
    _subCategory = value;
    notifyListeners();
  }

  CategoryModel(this._categoryId) {
    _fetchDetails();
    pageLoadController = PagewiseLoadController(
      pageFuture: (pageIndex) => productsByPage(
        pageIndex + 1,
        _categoryId,
        _subCategoryId,
      ),
      pageSize: 15,
    );
  }

  Future _fetchDetails() async {
    var result = await Future.wait([
      _repository.categoryDetails(_categoryId),
      _repository.subCategories(_categoryId, false),
    ]);

    Category categoryDetails =
        categoryFromHJson(result[0].data)?.success?.categories?.first;
    if (categoryDetails != null) this.category = categoryDetails;

    var subCategories = categoryFromHJson(result[1].data).success.categories;
    if (subCategories.isNotEmpty) {
      this.subCategories = subCategories;
    }
  }

  void navigateToProductList(SubCategory category) {
    _navigationService.navigateTo(
      routes.ProductsRoute,
      arguments: category,
    );
  }

  Future<List<Product>> productsByPage(
    int pageIndex,
    String categoryId,
    String subCategoryId,
  ) async {
    final result = await _repository.productsByCategoryWithPage(
      categoryId,
      subCategoryId,
      pageIndex,
    );
    var response = productFromJson(result.data);
    _maxCount.add(int.parse(response.success.totalProducts));
    return response.success.products;
  }
}
