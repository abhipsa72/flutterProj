import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/bar_chart_md.dart';
import 'package:zel_app/model/line_chart_response.dart';
import 'package:zel_app/model/repeat_refresh.dart';
import 'package:zel_app/model/role_details.dart';
import 'package:zel_app/model/sale_product.dart';
import 'package:zel_app/model/saled_impact_chart.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/model/wip_products.dart';
import 'package:zel_app/util/dio_network.dart';

class ManagingDirectorProvider extends ChangeNotifier {
  final _rolesController = BehaviorSubject<List<String>>();
  final _regionController = BehaviorSubject<List<String>>();
  final _roleDetailsController = BehaviorSubject<RoleDetails>();
  final _lineChartController = BehaviorSubject<LineChartResponse>();
  final _barChartController = BehaviorSubject<DepartmentSales>();
  final _salesImpactChartController = BehaviorSubject<SalesImpact>();
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
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
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

  setAuthTokenAndCompanyId(String token, String id) {
    this._authToken = token;
    this._companyId = id;
    lineChartForManagingDirector();
    salesImpactChartForManagingDirector();
    flowProgressionManagingDirector();
    barChartForManagingDirector();
    getWorkInProgressAlarms();
    getSalesAlarms();
  }

  void refreshChart() {
    lineChartForManagingDirector();
    salesImpactChartForManagingDirector();
    flowProgressionManagingDirector();
    barChartForManagingDirector();
  }

  void refreshProductRegion() {
    getSalesAlarms();
    getSalesAlarmRefresh();
  }

  void refreshProductStore() {
    getWorkInProgressAlarms();
    getSalesAlarmRefresh();
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

  setFromAndEndDates(SelectedDates selectedDates) {
    this._selectedDates = selectedDates;
    notifyListeners();
  }

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

  Stream<LineChartResponse> get lineChartStream => _lineChartController.stream;

  StreamSink<LineChartResponse> get lineChartSink => _lineChartController.sink;

  Stream<SalesImpact> get saleImpactStream =>
      _salesImpactChartController.stream;

  StreamSink<SalesImpact> get saleImpactSink =>
      _salesImpactChartController.sink;

  Stream<DepartmentSales> get barChartStream => _barChartController.stream;

  StreamSink<DepartmentSales> get barChartSink => _barChartController.sink;

  Stream<RoleDetails> get roleDetailsStream => _roleDetailsController.stream;

  StreamSink<RoleDetails> get roleDetailsSink => _roleDetailsController.sink;

  Stream<List<String>> get rolesStream => _rolesController.stream;

  StreamSink<List<String>> get rolesSink => _rolesController.sink;

  Stream<List<String>> get regionStream => _regionController.stream;

  StreamSink<List<String>> get regionSink => _regionController.sink;

  ManagingDirectorProvider(this._repository) {
    _selectedDates = SelectedDates(
        fromDate: formatter.format(DateTime.now().subtract(Duration(days: 7))),
        endDate: formatter.format(DateTime.now()));
  }

  setStoreToNull() {
    this._selectedStore = null;
  }

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

  lineChartForManagingDirector() async {
    isLoadingSink.add(true);
    lineChartSink.add(null);
    try {
      final result = await _repository.lineChartForManagingDirector(
        _authToken,
        _selectedRegion,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _apiState,
        _selectedStore,
      );
      LineChartResponse lineChart = lineChartResponseFromJson(result.data);
      lineChartSink.add(lineChart);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      lineChartSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  salesImpactChartForManagingDirector() async {
    isLoadingSink.add(true);
    saleImpactSink.add(null);
    try {
      final result = await _repository.salesImpactChart(
          _authToken,
          _selectedRegion,
          _selectedDates.fromDate,
          _selectedDates.endDate,
          _apiState,
          _selectedStore);
      SalesImpact lineChart = salesImpactChartFromJson(result.data);
      saleImpactSink.add(lineChart);
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
      saleImpactSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  flowProgressionManagingDirector() async {
    isLoadingSink.add(true);
    roleDetailsSink.add(null);
    try {
      final result = await _repository.flowProgressionManagingDirector(
        _authToken,
        _selectedRegion,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _apiState,
        _companyId,
      );
      RoleDetails details = roleDetailsFromJson(result.data);
      roleDetailsSink.add(details);
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
      roleDetailsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  barChartForManagingDirector() async {
    isLoadingSink.add(true);
    barChartSink.add(null);
    try {
      final result = await _repository.barChartManagingDirector(
        _authToken,
        _selectedRegion,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _apiState,
        _companyId,
        _selectedStore,
      );
      DepartmentSales details = departmentSalesFromJson(result.data);
      barChartSink.add(details);
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
      barChartSink.addError(error);
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

  dispose() {
    super.dispose();
    _salesAlarmProductsController.close();
    _wipAlarmProductsController.close();
    _storeController.close();
    _barChartController.close();
    _lineChartController.close();
    _roleDetailsController.close();
    _rolesController.close();
    _regionController.close();
    _salesImpactChartController.close();
    _productController.close();
    _loadingController.close();
    _progressController.close();
  }
}

enum ApiState { WithRegion, WithStore }
