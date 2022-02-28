import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/action_done.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/model/finance_action.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/model/product_status.dart';
import 'package:zel_app/model/selected_dates.dart';

class FinanceProviderBloc extends ChangeNotifier {
  final DataManagerRepository _repository;
  final _productListController = BehaviorSubject<List<Product>>();
  final _alarmDetailsController = BehaviorSubject<AlarmDetailsResponse>();
  final _productController = BehaviorSubject<Product>();
  final _actionListController = BehaviorSubject<List<ActionDone>>();
  final _actionController = BehaviorSubject<ActionDone>();
  final _loadingController = BehaviorSubject<bool>();
  final _storeController = BehaviorSubject<List<int>>();
  final _supplierController = BehaviorSubject<List<String>>();
  final _actionsController = BehaviorSubject<List<FinanceAction>>();
  final _subActionsController = BehaviorSubject<List<FinanceAction>>();
  final formatter = DateFormat('dd/MM/yyyy');
  SelectedDates _selectedDates = SelectedDates();
  String _authToken;
  String _companyId;
  String _selectedSupplier;
  Roles _userRole = Roles.ROLE_FINANCE;
  int _selectedStore;

  FinanceAction _selectedAction;
  FinanceAction _selectedSubAction;
  String _targetDays;

  set targetDays(String value) {
    this._targetDays = value;
  }

  SelectedDates get selectedDates => _selectedDates;

  FinanceAction get selectedAction => _selectedAction;

  FinanceAction get selectedSubAction => _selectedSubAction;

  int get selectedStore => _selectedStore;

  String get selectedSupplier => _selectedSupplier;

  Product get product => _productController.value;

  set setProduct(Product product) {
    this.productSink.add(product);
  }

  set setActionDone(ActionDone prod) {
    this.actionSink.add(prod);
  }

  set setSelectedStore(int store) {
    this._selectedStore = store;
  }

  set setSelectedSupplier(String supplier) {
    this._selectedSupplier = supplier;
  }

  setSupplierToNull() {
    this._selectedSupplier = null;
  }

  set setSelectedAction(FinanceAction action) {
    this._selectedAction = action;
  }

  setActionToNull() {
    this._selectedAction = null;
  }

  set setSelectedSubAction(FinanceAction action) {
    this._selectedSubAction = action;
  }

  setSubActionToNull() {
    this._selectedSubAction = null;
  }

  FinanceProviderBloc(this._repository) {
    _selectedDates = SelectedDates(
        fromDate: formatter.format(DateTime.now().subtract(Duration(days: 7))),
        endDate: formatter.format(DateTime.now()));
  }

  setAuthTokenAndCompanyId(String token, String id) {
    _authToken = token;
    _companyId = id;
    financeProductList();
    alarmDetails();
    //getStore();
    finanaceActionList();
    // getDepartments();
    //getPermissionsByRole();
  }

  setFromAndEndDates(SelectedDates selectedDates) {
    this._selectedDates = selectedDates;
    notifyListeners();
    financeProductList();
    alarmDetails();
  }

  Stream<List<int>> get storeListStream => _storeController.stream;

  StreamSink<List<int>> get storeListSink => _storeController.sink;

  Stream<List<String>> get supListStream => _supplierController.stream;

  StreamSink<List<String>> get supListSink => _supplierController.sink;

  Stream<List<FinanceAction>> get actionsStream => _actionsController.stream;

  StreamSink<List<FinanceAction>> get actionsSink => _actionsController.sink;

  Stream<List<FinanceAction>> get subActionsStream =>
      _subActionsController.stream;

  StreamSink<List<FinanceAction>> get subActionsSink =>
      _subActionsController.sink;

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

  financeProductList() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.financeProductList(
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
      finanaceActionList();

      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error);
      productListSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  finanaceActionList() async {
    isLoadingSink.add(true);
    actionListSink.add(List<ActionDone>());
    try {
      final result = await _repository.financeActionTable(
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
      final result = await _repository.financeDetails(
        _authToken,
        Roles.ROLE_FINANCE,
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
        financeProductList();
      }
    } on DioError catch (error) {
      print(error);
    }
  }

//  getStore() async {
//    storeListSink.add(null);
//    try {
//      final result = await _repository.getStores(_authToken);
//      List<int> stores = (result.data as List).cast<int>();
//      storeListSink.add(stores);
//    } on DioError catch (error) {
//      storeListSink.addError(error);
//    }
//  }

//  getDepartments() async {
//    supListSink.add(null);
//    try {
//      final result = await _repository.setSuppliers(_authToken);
//      List<String> stores = (result.data as List).cast<String>();
//      supListSink.add(stores);
//    } on DioError catch (error) {
//      supListSink.addError(error);
//    }
//  }

  dispose() {
    super.dispose();
    _productListController.close();
    _alarmDetailsController.close();
    _productController.close();
    _loadingController.close();
    _actionsController.close();
    _storeController.close();
    _supplierController.close();
    _subActionsController.close();
    _actionListController.close();
    _actionController.close();
  }

  getFilterList() async {
    productListSink.add(null);
    try {
      final result = await _repository.getFilter(
        Roles.ROLE_FINANCE,
        _authToken,
        _selectedSupplier,
      );
      List<Product> products = productsFromJson(result.data);
      productListSink.add(products);
    } on DioError catch (error) {
      productListSink.addError(error);
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

  numberOfTargetDays(String value) {
    this._targetDays = value;
  }

//  getActions() async {
//    actionsSink.add(List<FinanceAction>());
//    subActionsSink.add(List<FinanceAction>());
//    isLoadingSink.add(true);
//    try {
//      final result = await _repository.financeActions(_authToken, _userRole, _productController.value.threadId,);
//      List<FinanceAction> actions = financeActionFromJson(result.data);
//      if (actions.isEmpty) {
//        actionsSink.addError("No data");
//      }
//      actionsSink.add(actions);
//      isLoadingSink.add(false);
//    } on DioError catch (error) {
//      actionsSink.addError(error);
//      isLoadingSink.add(false);
//    }
//  }

  getSubActions(String id) async {
    subActionsSink.add(List<FinanceAction>());
    isLoadingSink.add(true);
    try {
      final result = await _repository.financeSubActions(_authToken, id);
      List<FinanceAction> actions = financeActionFromJson(result.data);
      subActionsSink.add(actions);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      subActionsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getPermissionsByRole() async {
    isLoadingSink.add(true);
    actionsSink.add(List<FinanceAction>());
    subActionsSink.add(List<FinanceAction>());
    try {
      final result = await _repository.financeActions(
        _authToken,
        _userRole,
        _productController.value.threadId,
      );
      List<FinanceAction> permissions = financeActionFromJson(result.data);
      actionsSink.add(permissions);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      actionsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getSubActionsByAction(String id) async {
    subActionsSink.add(List<FinanceAction>());
    isLoadingSink.add(true);
    try {
      final result = await _repository.financeSubActions(_authToken, id);
      List<FinanceAction> actions = financeActionFromJson(result.data);
      subActionsSink.add(actions);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      subActionsSink.addError(error);
      isLoadingSink.add(false);
    }
  }
}
