import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/enums/enum_values.dart';
import 'package:grand_uae/customer/enums/sort_with_order.dart';
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/model/category_response.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController searchQuery = TextEditingController();
  String errorMessage;
  Timer _debounceTimer;
  Category _selectedCategory;
  Category _selectedSubCategory;
  SortWithOrder _selectedSort = SortWithOrder.Default;

  List<Category> _categories = [];
  List<Category> _subCategories = [];
  List<Product> _productsList = [];

  SortWithOrder get selectedSort => _selectedSort;

  List<Category> get subCategories => _subCategories;

  List<Category> get categories => _categories;

  List<Product> get productsList => _productsList;

  Category get selectedCategory => _selectedCategory;

  Category get selectedSubCategory => _selectedSubCategory;

  set selectedCategory(Category value) {
    _selectedCategory = value;
    notifyListeners();
  }

  set selectedSubCategory(Category value) {
    _selectedSubCategory = value;
    notifyListeners();
  }

  set productsList(List<Product> value) {
    print(value.length);
    _productsList = value;
    notifyListeners();
  }

  set categories(List<Category> value) {
    _categories = value;
    notifyListeners();
  }

  set subCategories(List<Category> value) {
    _subCategories = value;
    notifyListeners();
  }

  set selectedSort(SortWithOrder value) {
    _selectedSort = value;
    notifyListeners();
  }

  SearchModel() {
    searchQuery.addListener(() {
      if (_debounceTimer != null) {
        _debounceTimer.cancel();
      }
      _debounceTimer = Timer(Duration(milliseconds: 500), () {
        search(searchQuery.text);
      });
    });
    _fetchCategories();
  }

  Future search(String search) async {
    setState(ViewState.Busy);
    try {
      String sort = sortMap.reverse[_selectedSort];
      setState(ViewState.Busy);
      final result = await _repository.search(
        search,
        sort,
        _selectedCategory?.categoryId,
        _selectedSubCategory?.categoryId,
      );

      var products = productFromJson(result.data).success.products;
      productsList = products;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
    }
  }

  Future _fetchCategories() async {
    try {
      var result = await _repository.categories(false);
      categories = categoryFromHJson(result.data).success.categories;
    } catch (error) {
      categories = [];
      print(error);
    }
  }

  Future fetchSubCategories(String categoryId) async {
    subCategories = [];
    selectedSubCategory = null;
    try {
      var result = await _repository.subCategories(categoryId, false);
      subCategories = categoryFromHJson(result.data).success.categories;
    } catch (error) {
      subCategories = [];
      print(error);
    }
  }

  @override
  void dispose() {
    searchQuery.dispose();
    _debounceTimer = null;
    super.dispose();
  }

  void navigateToProductDetails(Product product) {
    _navigationService.navigateTo(
      routes.ProductDetailsRoute,
      arguments: product.productId,
    );
  }

  void clear() {
    selectedSort = SortWithOrder.Default;
    _selectedCategory = null;
    _selectedSubCategory = null;
    subCategories = [];
    searchQuery.clear();
  }
}

var sortMap = EnumValues<SortWithOrder>({
  'sort=p.sort_order&order=ASC': SortWithOrder.Default,
  'sort=pd.name&order=ASC': SortWithOrder.Name_A_Z,
  'sort=pd.name&order=DESC': SortWithOrder.Name_Z_A,
  'sort=p.price&order=ASC': SortWithOrder.Price_High_Low,
  'sort=p.price&order=DESC': SortWithOrder.Price_Low_High,
  'sort=rating&order=DESC': SortWithOrder.Rating_High_Low,
  'sort=rating&order=ASC': SortWithOrder.Rating_Low_High,
  'sort=p.model&order=ASC': SortWithOrder.Model_A_Z,
  'sort=p.model&order=DESC': SortWithOrder.Model_Z_A,
});
