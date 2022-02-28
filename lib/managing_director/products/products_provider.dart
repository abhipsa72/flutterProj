import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/model/selected_dates.dart';

class ProductProvider extends ChangeNotifier {
  final DataManagerRepository _repository;
  final _productListController = BehaviorSubject<List<Product>>();
  final _productController = BehaviorSubject<Product>();
  final _loadingController = BehaviorSubject<bool>();
  final _roleController=BehaviorSubject<List<String>>();
  //final _actionsController = BehaviorSubject<List<WarehouseAction>>();
 // final _permissionsController = BehaviorSubject<List<WarehouseAction>>();
  final _storeController = BehaviorSubject<List<int>>();
  final _regionController = BehaviorSubject<List<String>>();

  SelectedDates _selectedDates = SelectedDates();
  String _authToken;
  String _companyId;
  Roles _userRole = Roles.ROLE_MD;
  int _selectedStore;
  String _selectedRole;
  String _selectedRegion;


  SelectedDates get selectedDates => _selectedDates;


  int get selectedStore => _selectedStore;

  String get selectedRole => _selectedRole;
  String get selectedRegion => _selectedRegion;
  Product get product => _productController.value;

  set setProduct(Product product) {
    this.productSink.add(product);
  }

  set setSelectedStore(int store) {
    this._selectedStore = store;
  }

  set setSelectedRole(String role) {
    this._selectedRole = role;
  }
  set setSelectedRegion(String region) {
    this._selectedRole = region;
  }

  ProductProvider(this._repository);


  setAuthTokenAndCompanyId(String token, String id) {
    _authToken = token;
    _companyId = id;
    mdProductList();
    getStore();
    getRoles();
    getRegion();
  }

  void setAuthTokenAndRole(String token, Roles role) {
    this._authToken = token;
    this._userRole = role;
  }
  setFromAndEndDates(SelectedDates selectedDates) {
    this._selectedDates = selectedDates;
    notifyListeners();
    mdProductList();
  }

  Stream<List<int>> get storeListStream => _storeController.stream;

  StreamSink<List<int>> get storeListSink => _storeController.sink;

  Stream<List<String>> get roleListStream => _roleController.stream;

  StreamSink<List<String>> get roleListSink => _roleController.sink;

  Stream<List<String>> get regionListStream => _regionController.stream;

  StreamSink<List<String>> get regionListSink => _regionController.sink;

  Stream<bool> get isLoadingStream => _loadingController.stream;

  Stream<Product> get productStream => _productController.stream;

  StreamSink<Product> get productSink => _productController.sink;

  Stream<List<Product>> get productListStream => _productListController.stream;

  StreamSink<List<Product>> get productListSink => _productListController.sink;


  Stream<bool> get isLoading => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;

  mdProductList() async {
    isLoadingSink.add(true);
    productListSink.add(null);
    try {
      final result = await _repository.mdProductList(
          _selectedRegion,
          _selectedDates.fromDate,
          _selectedDates.endDate,
          _authToken);
      List<Product> products = productsFromJson(result.data);
      if (products.isEmpty) {
        productListSink.addError("No data");
      }
      productListSink.add(products);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error);
      productListSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  mdWIPList() async {
    isLoadingSink.add(true);
    productListSink.add(null);
    try {
      final result = await _repository.mdWIPList(
          _selectedRegion,
          _selectedDates.fromDate,
          _selectedDates.endDate,
          _authToken);
      List<Product> products = productsFromJson(result.data);
      if (products.isEmpty) {
        productListSink.addError("No data");
      }
      productListSink.add(products);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error);
      productListSink.addError(error);
      isLoadingSink.add(false);
    }
  }
  getStore() async {
    storeListSink.add(null);
    try {
      final result = await _repository.getAllStores(_authToken,_selectedRegion);
      List<int> stores = (result.data as List).cast<int>();
      storeListSink.add(stores);
    } on DioError catch (error) {
      storeListSink.addError(error);
    }
  }

  getRoles() async {
    roleListSink.add(null);
    try {
      final result = await _repository.getRoles(_authToken);
      List<String> roles = (result.data as List).cast<String>();
      roleListSink.add(roles);
    } on DioError catch (error) {
      roleListSink.addError(error);
    }
  }
  getRegion() async {
    regionListSink.add(null);
    try {
      final result = await _repository.getRegions(_authToken);
      List<String> roles = (result.data as List).cast<String>();
      regionListSink.add(roles);
    } on DioError catch (error) {
      regionListSink.addError(error);
    }
  }
  dispose() {
    super.dispose();
    _productListController.close();
    _productController.close();
    _loadingController.close();
    _storeController.close();
    _regionController.close();
    _roleController.close();
  }

//  getFilterList() async {
//    productListSink.add(null);
//    try {
//      final result = await _repository.getFilterProducts(
//        Roles.ROLE_PURCHASER,
//        _authToken,
//        _selectedStore,
//        _selectedDepartment,
//        _selectedDates.fromDate,
//        _selectedDates.endDate,
//      );
//      List<Product> products = productsFromJson(result.data);
//      productListSink.add(products);
//    } on DioError catch (error) {
//      productListSink.addError(error);
//    }
//  }

}
