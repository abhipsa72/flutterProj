import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/action_done.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/model/permission.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/model/product_status.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/model/store_filter.dart';

class PurchaserProvider extends ChangeNotifier {
  final DataManagerRepository _repository;

  final _productListController = BehaviorSubject<List<Product>>();
  final _alarmDetailsController = BehaviorSubject<AlarmDetailsResponse>();
  final _productController = BehaviorSubject<Product>();
  final _actionListController = BehaviorSubject<List<ActionDone>>();
  final _actionController = BehaviorSubject<ActionDone>();
  final _loadingController = BehaviorSubject<bool>();
  final _actionsController = BehaviorSubject<List<WarehouseAction>>();
  final _asignController = BehaviorSubject<List<WarehouseAction>>();
  final _permissionsController = BehaviorSubject<List<WarehouseAction>>();
  final _storeController = BehaviorSubject<List<String>>();
  final _departmentController = BehaviorSubject<List<String>>();
  final formatter = DateFormat('dd/MM/yyyy');
  SelectedDates _selectedDates = SelectedDates();
  String _authToken;
  String _companyId;
  String _selectedSupplier;
  Roles _userRole = Roles.ROLE_PURCHASER;
  String _selectedStore;
  String _selectedDepartment;
  WarehouseAction _selectedAction;
  WarehouseAction _selectedSubAction;
  WarehouseAction _selectedAsign;
  String _targetDays;

  set targetDays(String value) {
    this._targetDays = value;
  }

  SelectedDates get selectedDates => _selectedDates;

  WarehouseAction get selectedAction => _selectedAction;

  WarehouseAction get selectedSubAction => _selectedSubAction;

  WarehouseAction get selectedAsign => _selectedAsign;
  String get selectedStore => _selectedStore;

  String get selectedDepartment => _selectedDepartment;

  Product get product => _productController.value;

  set setProduct(Product product) {
    this.productSink.add(product);
  }

  set setActionDone(ActionDone prod) {
    this.actionSink.add(prod);
  }

  set setSelectedStore(String store) {
    this._selectedStore = store;
  }

  set setSelectedDepartment(String department) {
    this._selectedDepartment = department;
  }

  set setSelectedAction(WarehouseAction action) {
    this._selectedAction = action;
  }

  setActionToNull() {
    this._selectedAction = null;
  }

  set setSelectedSubAction(WarehouseAction action) {
    this._selectedSubAction = action;
  }

  set setSelectedAsign(WarehouseAction action) {
    this._selectedAsign = action;
  }

  setSubActionToNull() {
    this._selectedSubAction = null;
  }

  setAsignToNull() {
    this._selectedAsign = null;
  }

  PurchaserProvider(this._repository) {
    _selectedDates = SelectedDates(
        fromDate: formatter.format(DateTime.now().subtract(Duration(days: 7))),
        endDate: formatter.format(DateTime.now()));
  }

  String get selectedSupplier => _selectedSupplier;

  set setSelectedSupplier(String val) {
    this._selectedSupplier = val;
    setSupplier(val);
  }

  setSupplierToNull() {
    this._selectedSupplier = null;
  }

  setAuthTokenAndCompanyId(String token, String id) {
    _authToken = token;
    _companyId = id;
    purchaserProductList();
    purchaserActionList();
    alarmDetails();
    getStore();
    getDepartments();
    // getPermissionsByRole();
  }

  void setAuthTokenAndRole(String token, Roles role) {
    this._authToken = token;
    this._userRole = role;
  }

  setFromAndEndDates(SelectedDates selectedDates) {
    this._selectedDates = selectedDates;
    notifyListeners();
    purchaserProductList();
    purchaserActionList();
    alarmDetails();
    // getPermissionsByRole();
  }

  Stream<List<String>> get storeListStream => _storeController.stream;

  StreamSink<List<String>> get storeListSink => _storeController.sink;

  Stream<List<String>> get departmentListStream => _departmentController.stream;

  StreamSink<List<String>> get departmentListSink => _departmentController.sink;

  Stream<List<WarehouseAction>> get permissionsStream =>
      _permissionsController.stream;

  StreamSink<List<WarehouseAction>> get permissionsSink =>
      _permissionsController.sink;

  Stream<List<WarehouseAction>> get subActionsStream =>
      _actionsController.stream;

  StreamSink<List<WarehouseAction>> get subActionsSink =>
      _actionsController.sink;
  Stream<List<WarehouseAction>> get asignStream => _asignController.stream;

  StreamSink<List<WarehouseAction>> get asignSink => _asignController.sink;
  Stream<bool> get isLoadingStream => _loadingController.stream;

  Stream<Product> get productStream => _productController.stream;

  StreamSink<Product> get productSink => _productController.sink;

  Stream<List<Product>> get productListStream => _productListController.stream;

  StreamSink<List<Product>> get productListSink => _productListController.sink;

  Stream<List<ActionDone>> get actionListStream => _actionListController.stream;

  StreamSink<List<ActionDone>> get actionListSink => _actionListController.sink;

  Stream<ActionDone> get actionStream => _actionController.stream;

  StreamSink<ActionDone> get actionSink => _actionController.sink;

  Stream<AlarmDetailsResponse> get alarmDetailStream =>
      _alarmDetailsController.stream;

  StreamSink<AlarmDetailsResponse> get alarmDetailsSink =>
      _alarmDetailsController.sink;

  Stream<bool> get isLoading => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;

  purchaserProductList() async {
    isLoadingSink.add(true);

    try {
      final result = await _repository.purchaserProductList(
        _authToken,
        _userRole,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      List<Product> products = productsFromJson(result.data);
      if (products.isEmpty) {
        productListSink.addError("No data");
      }
      productListSink.add(products);
      //getPermissionsByRole();
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error);
      productListSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  purchaserActionList() async {
    isLoadingSink.add(true);
    actionListSink.add(List<ActionDone>());
    try {
      final result = await _repository.purchaserActionTable(
        _authToken,
        _userRole,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      List<ActionDone> products = actionDoneFromJson(result.data);
      actionListSink.add(products);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error);
      actionListSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  alarmDetails() async {
    isLoadingSink.add(true);
    alarmDetailsSink.add(null);
    try {
      final result = await _repository.purchaserDetails(
        _authToken,
        Roles.ROLE_PURCHASER,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      AlarmDetailsResponse details = AlarmDetailsResponse.fromJson(result.data);
      alarmDetailsSink.add(details);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      alarmDetailsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  setSupplier(String supplierName) async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.setSupplier(
        _authToken,
        _productController.value.id,
        supplierName,
      );
      ProductStatus productStatus = productStatusFromJson(result.data);
      if (productStatus.status) {
        productSink.add(productStatus.product);
      }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      isLoadingSink.add(false);
    }
  }

  getPermissionsByRole() async {
    isLoadingSink.add(true);
    permissionsSink.add(List<WarehouseAction>());
    subActionsSink.add(List<WarehouseAction>());
    asignSink.add(List<WarehouseAction>());
    try {
      final result = await _repository.getPermissionOnRole(
        _authToken,
        Roles.ROLE_PURCHASER,
        _productController.value.threadId,
      );
      List<WarehouseAction> permissions = wareHouseActionFromJson(result.data);
      permissionsSink.add(permissions);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      permissionsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getSubActionsByAction(String id) async {
    subActionsSink.add(List<WarehouseAction>());
    asignSink.add(List<WarehouseAction>());
    isLoadingSink.add(true);
    try {
      final result = await _repository.getSubActionByPermission(_authToken, id);
      List<WarehouseAction> actions = wareHouseActionFromJson(result.data);
      subActionsSink.add(actions);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      subActionsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getReasignByAction(String id) async {
    asignSink.add(List<WarehouseAction>());
    isLoadingSink.add(true);
    try {
      final result = await _repository.getAsignByPermission(_authToken, id);
      List<WarehouseAction> actions = wareHouseActionFromJson(result.data);
      asignSink.add(actions);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      asignSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  filterAlaram(String value) async {
    productListSink.add(null);
    print(_userRole);
    try {
      final result = await _repository.filterAlaram(_authToken, _userRole,
          _selectedDates.fromDate, _selectedDates.endDate, value);
      List<Product> products = productsFromJson(result.data);
      productListSink.add(products);
    } on DioError catch (error) {
      productListSink.addError(error);
    }
  }

  getSalesAlarmsyScode() async {
    productListSink.add(null);
    try {
      final result = await _repository.getFilterByScode(
        _authToken,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _selectedStore,
        Roles.ROLE_PURCHASER,
      );
      StoreFilter productStatus = storeFilterFromJson(result.data);

      if (productStatus.message == "sales alarms found successfully !!") {
        productListSink.add(productStatus.product);
      } else {
        productListSink.add(List<Product>());
      }
    } on DioError catch (error) {
      productListSink.addError(error);
    }
  }

  getSalesAlarmsByDept() async {
    productListSink.add(null);
    try {
      final result = await _repository.getFilterByDept(
        _authToken,
        _selectedDates.fromDate,
        _selectedDates.endDate,
        _selectedDepartment,
        Roles.ROLE_PURCHASER,
      );
      StoreFilter productStatus = storeFilterFromJson(result.data);
      if (productStatus.message == "sales alarms found successfully !!") {
        productListSink.add(productStatus.product);
      } else {
        productListSink.add(List<Product>());
      }
    } on DioError catch (error) {
      productListSink.addError(error);
    }
  }

  saveDetails() async {
    try {
      final result = await _repository.setWorkFlowToProduct(
        _selectedAction.hasRole == 3
            ? _selectedSubAction.id
            : _selectedAction.id,
        _authToken,
        product.id,
        _targetDays,
      );
      ProductStatus productStatus = productStatusFromJson(result.data);
      if (productStatus.status) {
        productSink.add(productStatus.product);
        purchaserProductList();
      }
    } on DioError catch (error) {
      print(error);
    }
  }

  saveAsign() async {
    try {
      final result = await _repository.setWorkFlowToProduct(
        _selectedAsign.id,
        _authToken,
        product.id,
        _targetDays,
      );
      ProductStatus productStatus = productStatusFromJson(result.data);
      if (productStatus.status) {
        productSink.add(productStatus.product);
        purchaserProductList();
      }
    } on DioError catch (error) {
      print(error);
    }
  }

  getStore() async {
    storeListSink.add(null);
    try {
      final result = await _repository.getStores(_authToken);
      List<String> stores = (result.data as List).cast<String>();
      storeListSink.add(stores);
    } on DioError catch (error) {
      storeListSink.addError(error);
    }
  }

  getDepartments() async {
    departmentListSink.add(null);
    try {
      final result = await _repository.getDepartments(_authToken);
      List<String> stores = (result.data as List).cast<String>();
      departmentListSink.add(stores);
    } on DioError catch (error) {
      departmentListSink.addError(error);
    }
  }

  dispose() {
    super.dispose();
    _actionListController.close();
    _actionController.close();
    _productListController.close();
    _alarmDetailsController.close();
    _productController.close();
    _loadingController.close();
    _actionsController.close();
    _permissionsController.close();
    _storeController.close();
    _departmentController.close();
    _asignController.close();
  }

  getFilterList() async {
    productListSink.add(null);
    try {
      final result = await _repository.getFilterProducts(
        _authToken,
        Roles.ROLE_PURCHASER,
        _selectedDepartment,
        _selectedStore,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      List<Product> products = productsFromJson(result.data);
      productListSink.add(products);
    } on DioError catch (error) {
      productListSink.addError(error);
    }
  }

  void numberOfTargetDays(String value) {
    this._targetDays = value;
  }
}
