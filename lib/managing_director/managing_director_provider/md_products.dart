import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/repeat_refresh.dart';
import 'package:zel_app/model/sale_product.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/model/wip_products.dart';
import 'package:zel_app/util/dio_network.dart';

class ManagingDirectorProducts extends ChangeNotifier {
  final _rolesController = BehaviorSubject<List<String>>();
  final _regionController = BehaviorSubject<List<String>>();
  final _storeController = BehaviorSubject<List<String>>();
  final _wipAlarmProductsController = BehaviorSubject<List<WiProduct>>();
  final _salesAlarmProductsController = BehaviorSubject<List<SaleProduct>>();
  final _productController = BehaviorSubject<SaleProduct>();
  final _productListRefreshController = BehaviorSubject<List<RepeatRefresh>>();
  final _productRefreshController = BehaviorSubject<RepeatRefresh>();
  final _progressController = BehaviorSubject<WiProduct>();
  final DataManagerRepository _repository;
  final _loadingController = BehaviorSubject<bool>();
  final formatter = DateFormat('dd/MM/yyyy');
  ApiState _apiState = ApiState.WithRegion;
  SelectedDates _selectedDates = SelectedDates();
  String _authToken;
  String _companyId;
  String _selectedStore;
  String _selectedRole;
  String _selectedRegion;

  ManagingDirectorProducts(this._repository) {
    _selectedDates = SelectedDates(
        fromDate: formatter.format(DateTime.now().subtract(Duration(days: 7))),
        endDate: formatter.format(DateTime.now()));
  }

  ApiState get apiState => _apiState;
  SelectedDates get selectedDates => _selectedDates;

  set setApiState(ApiState apiState) {
    this._apiState = apiState;
  }

  String get selectedStore => _selectedStore;

  set setSelectedStore(String store) {
    this._selectedStore = store;
  }

  String get selectedRole => _selectedRole;

  set setSelectedRole(String store) {
    this._selectedRole = store;
  }

  String get selectedRegion => _selectedRegion;

  set setSelectedRegion(String store) {
    this._selectedRegion = store;
  }

  set setProduct(SaleProduct product) {
    this.productSink.add(product);
  }

  set setRefresh(RepeatRefresh product) {
    this.productRefreshSink.add(product);
  }

  set setProgress(WiProduct product) {
    this.progressSink.add(product);
  }

  Stream<List<String>> get rolesStream => _rolesController.stream;

  StreamSink<List<String>> get rolesSink => _rolesController.sink;

  Stream<List<String>> get regionStream => _regionController.stream;

  StreamSink<List<String>> get regionSink => _regionController.sink;

  Stream<bool> get isLoadingStream => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;

  Stream<SaleProduct> get productStream => _productController.stream;

  StreamSink<SaleProduct> get productSink => _productController.sink;

  Stream<List<RepeatRefresh>> get productListRefreshStream =>
      _productListRefreshController.stream;

  StreamSink<List<RepeatRefresh>> get productListRefreshSink =>
      _productListRefreshController.sink;

  Stream<RepeatRefresh> get productRefreshStream =>
      _productRefreshController.stream;

  StreamSink<RepeatRefresh> get productRefreshSink =>
      _productRefreshController.sink;

  Stream<WiProduct> get progressStream => _progressController.stream;

  StreamSink<WiProduct> get progressSink => _progressController.sink;

  Stream<List<String>> get storeListStream => _storeController.stream;

  StreamSink<List<String>> get storeListSink => _storeController.sink;

  Stream<List<WiProduct>> get wipProductsListStream =>
      _wipAlarmProductsController.stream;

  StreamSink<List<WiProduct>> get wipProductListSink =>
      _wipAlarmProductsController.sink;

  Stream<List<SaleProduct>> get salesProductsListStream =>
      _salesAlarmProductsController.stream;

  StreamSink<List<SaleProduct>> get salesProductListSink =>
      _salesAlarmProductsController.sink;

  getStore(String region) async {
    storeListSink.add(List<String>());
    try {
      final result = await _repository.getStoresByRegion(
        _authToken,
        region,
      );
      List<String> stores = (result.data as List).cast<String>();
      storeListSink.add(stores);
    } on DioError catch (error) {
      storeListSink.addError(error);
    }
  }

  getAllRoles() async {
    rolesSink.add(List<String>());
    storeListSink.add(List<String>());
    try {
      final result = await _repository.getAllRole(_authToken);
      List<String> roles = (result.data as List).cast<String>();
      if (roles.isNotEmpty) {
        rolesSink.add(roles);
      } else {
        rolesSink.addError("No data");
      }
    } on DioError catch (error) {
      rolesSink.addError(error);
    }
  }

  getAllRegion() async {
    regionSink.add(List<String>());
    storeListSink.add(List<String>());
    try {
      final result = await _repository.getAllRegion(_authToken);
      List<String> roles = (result.data as List).cast<String>();
      if (roles.isNotEmpty) {
        regionSink.add(roles);
      } else {
        regionSink.addError("No data");
      }
    } on DioError catch (error) {
      regionSink.addError(error);
    }
  }

  getWorkInProgressAlarms() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.getWorkInProgressAlarms(
        _authToken,
        _selectedRegion,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _apiState,
        _selectedStore,
      );
      List<WiProduct> list = wiProductFromJson(result.data);
      wipProductListSink.add(list);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      print(error.toString());
      isLoadingSink.add(false);
      wipProductListSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getSalesAlarms() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.getSalesAlarms(
        _authToken,
        _selectedRegion,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _apiState,
      );
      List<SaleProduct> list = salesProductFromJson(result.data);
      if (list.isEmpty)
        salesProductListSink.addError("No data");
      else
        salesProductListSink.add(list);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      print(error.toString());
      isLoadingSink.add(false);
      salesProductListSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getSalesAlarmRefresh() async {
    isLoadingSink.add(true);

    try {
      final result = await _repository.getSalesAlarmsRefresh(
        _authToken,
        _selectedRegion,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _apiState,
        _selectedStore,
      );
      List<RepeatRefresh> list = repeatRefreshFromJson(result.data);
      if (list.isEmpty)
        productListRefreshSink.addError("No data");
      else
        productListRefreshSink.add(list);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      print(error.toString());
      isLoadingSink.add(false);
      productListRefreshSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getWorkInProgressAlarmsByRole() async {
    isLoadingSink.add(true);
    wipProductListSink.add(List<WiProduct>());
    try {
      final result = await _repository.getWorkInProgressAlarmsByRole(
        _authToken,
        _selectedRole,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      List<WiProduct> list = wiProductFromJson(result.data);
      wipProductListSink.add(list);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      wipProductListSink.addError(error);
      isLoadingSink.add(false);
    }
  }
}
