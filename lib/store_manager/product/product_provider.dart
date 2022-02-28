import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/action.dart';
import 'package:zel_app/model/action_done.dart';
import 'package:zel_app/model/alarm.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/model/search.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/model/store_product.dart';
import 'package:zel_app/model/store_status.dart';
import 'package:zel_app/model/sub_action.dart';

/*
class ProductListingProvider extends Loading {
  final DataManagerRepository _repository;

  Alarm _selectedAlarm;
  AlarmAction _selectedAction;
  SubAction _selectedSubAction;
  Product _product;
  String _authToken;
  String _companyId;
  String _fromDate = "01/03/2020";
  String _endDate = "07/03/2020";
  String _barCode;
  bool showBarCode = false;
  bool showRemarks = false;
  String _remarks;
  List<Alarm> _alarmsList = List();
  List<AlarmAction> _actionList = List();
  List<SubAction> _subActionList = List();
  List<Product> _productList = List();

  String get fromDate => _fromDate;

  String get endDate => _endDate;

  UnmodifiableListView<Alarm> get alarms {
    return UnmodifiableListView(_alarmsList);
  }

  UnmodifiableListView<AlarmAction> get actions {
    return UnmodifiableListView(_actionList);
  }

  UnmodifiableListView<Product> get products {
    return UnmodifiableListView(_productList);
  }

  UnmodifiableListView<SubAction> get subAction {
    return UnmodifiableListView(_subActionList);
  }

  ProductListingProvider(this._repository);

  set setRemarks(String val) {
    this._remarks = val;
    notifyListeners();
  }

  String get remarks => _remarks;

  set setBarCode(String val) {
    this._barCode = val;
    notifyListeners();
  }

  String get barCode => _barCode;

  set setProduct(Product product) {
    this._product = product;
  }

  Product get product => _product;

  set setSelectedAlarm(final Alarm alarm) {
    this._selectedAlarm = alarm;
  }

  Alarm get selectedAlarm => _selectedAlarm;

  set setSelectedAction(final AlarmAction alarmAction) {
    this._selectedAction = alarmAction;
  }

  AlarmAction get selectedAction => _selectedAction;

  set setSelectedSubAction(final SubAction action) {
    this._selectedSubAction = action;
    if (_selectedSubAction.subActionName == "Local Market purchase") {
      showBarCode = true;
    }
  }

  SubAction get selectedSubAction => _selectedSubAction;

  setAuthTokenAndCompanyId(String token, String id) {
    this._authToken = token;
    this._companyId = id;
    allAlarms();
  }

  setFromAndEndDate(String fromDate, String endDate) {
    _fromDate = fromDate;
    _endDate = endDate;
    notifyListeners();
  }

  Future<Response> allProductsFuture() {
    return _repository.allProducts(
      _authToken,
      _companyId,
      _fromDate,
      _endDate,
    );
  }

  allProducts() async {
    try {
      final result = await _repository.allProducts(
        _authToken,
        _companyId,
        _fromDate,
        _endDate,
      );
      _productList = productsFromJson(result.data);
      notifyListeners();
    } on DioError catch (error) {
      print(error.toString());
    }
  }

  allAlarms() async {
    try {
      final result = await _repository.allAlarms(_authToken);
      _alarmsList = alarmResponseFromJson(result.data);
      _selectedAlarm = _alarmsList[0];
    } on DioError catch (error) {
      print(error.toString());
    }
  }

  Future<Response> allAlarmsFuture() {
    return _repository.allAlarms(_authToken);
  }

  getActionsFromAlarm(String alarmName) async {
    try {
      final result =
          await _repository.getActionsFromAlarm(_authToken, alarmName);
      _actionList = actionFromJson(result.data);
      _selectedAction = _actionList[0];
      notifyListeners();
    } on DioError catch (error) {
      print(error.toString());
    }
  }

  void getSubActionFromAction(String action) async {
    try {
      final result =
          await _repository.getSubActionsFromAction(_authToken, action);
      _subActionList = subActionFromJson(result.data);
      _selectedSubAction = _subActionList[0];
      notifyListeners();
    } on DioError catch (error) {
      print(error.toString());
    }
  }

  void saveDetails(String productId) async {
    setLoading(true);
    try {
      final result = await _repository.saveDetails(
        _authToken,
        productId,
        selectedSubAction.subActionName,
        _remarks,
        _barCode,
        _companyId,
      );
      ProductStatus productStatus = productStatusFromJson(result.data);
      if (productStatus.status) {
        _product = productStatus.product;
        notifyListeners();
      }
      setLoading(false);
    } on DioError catch (error) {
      setLoading(false);
    }
  }

  void setRemarkable(String value) {
    this._remarks = value;
  }

  void setBarCodeValue(String value) {
    this._barCode = value;
  }
}
*/

class ProductListingProvider extends ChangeNotifier {
  final DataManagerRepository _repository;

  final _alarmListController = BehaviorSubject<List<Alarm>>();
  final _actionListController = BehaviorSubject<List<AlarmAction>>();
  final _subActionListController = BehaviorSubject<List<SubAction>>();
  final _level4ListController = BehaviorSubject<List<String>>();
  final _productListController = BehaviorSubject<List<StoreProduct>>();
  final _filterAlarmList = BehaviorSubject<List<StoreProduct>>();
  final _searchFilterController = BehaviorSubject<List<AlarmStat>>();
  final _loadingController = BehaviorSubject<bool>();
  final _productController = BehaviorSubject<StoreProduct>();
  final _filterAlarmController = BehaviorSubject<StoreProduct>();
  final _actionsListController = BehaviorSubject<List<ActionDone>>();
  final _actionController = BehaviorSubject<ActionDone>();
  final _alarmDetailsController = BehaviorSubject<AlarmDetailsResponse>();

  final level4DropDownList = [
    "Bought by store manager?",
    "Bought by purchaser?",
  ];

  final formatter = DateFormat('dd/MM/yyyy');
  SelectedDates _selectedDates = SelectedDates();
  String _authToken;
  String _companyId;
  Alarm _selectedAlarm;
  AlarmAction _selectedAction;
  SubAction _selectedSubAction;
  String _selectedLevel4Option;
  String _remarks;
  String _barCode;
  Roles _userRole = Roles.ROLE_STORE_MANAGER;
  StoreProduct get product => _productController.value;
  String _targetId;

  set targetId(String value) {
    this._targetId = value;
  }

  String get remarks => _remarks;

  String get barCode => _barCode;

  SelectedDates get selectedDates => _selectedDates;

  Alarm get selectedAlarm => _selectedAlarm;

  AlarmAction get selectedAction => _selectedAction;

  SubAction get selectedSubAction => _selectedSubAction;

  authToken(String token) {
    this._authToken = token;
  }

  setRemarks(String val) {
    this._remarks = val;
  }

  set setSelectedAlarm(final Alarm alarm) {
    this._selectedAlarm = alarm;
    getActionsFromAlarm(alarm.alarmName);
  }

  set setSelectedAction(final AlarmAction alarmAction) {
    this._selectedAction = alarmAction;
    getSubActionFromAction(alarmAction.action);
  }

  setAlaramToNull() {
    this._selectedAlarm = null;
    print("done");
  }

  setLevel4OptionToNull() {
    this._selectedLevel4Option = null;
  }

  setActionToNull() {
    this._selectedAction = null;
    print("done");
  }

  setSubActionToNull() {
    this._selectedSubAction = null;
    print("done");
  }

  set setSelectedSubAction(final SubAction action) {
    this._selectedSubAction = action;
    print("Subaction: ${action.subActionName}");
    if (action.subActionName.toLowerCase() == "local market purchase") {
      getLevel4Options(action.subActionName);
    }
  }

  set setSelected4Action(final String action) {
    this._selectedLevel4Option = action;
  }

  set setProduct(StoreProduct product) {
    this.productSink.add(product);
  }

  set setProductAlam(StoreProduct product) {
    this.filterAlarmSink.add(product);
  }

  set setActionDone(ActionDone prod) {
    this.actionSink.add(prod);
  }

  String get selected4Option => _selectedLevel4Option;

  Stream<List<StoreProduct>> get productListStream =>
      _productListController.stream;

  StreamSink<List<StoreProduct>> get productListSink =>
      _productListController.sink;

  Stream<List<StoreProduct>> get filterAlamListStream =>
      _filterAlarmList.stream;

  StreamSink<List<StoreProduct>> get filterAlamListSink =>
      _filterAlarmList.sink;

  Stream<List<AlarmStat>> get searchStateStream =>
      _searchFilterController.stream;

  StreamSink<List<AlarmStat>> get searchStateSink =>
      _searchFilterController.sink;

  Stream<StoreProduct> get productStream => _productController.stream;

  StreamSink<StoreProduct> get productSink => _productController.sink;

  Stream<StoreProduct> get filterAlarmStream => _filterAlarmController.stream;

  StreamSink<StoreProduct> get filterAlarmSink => _filterAlarmController.sink;

  Stream<bool> get isLoading => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;

  Stream<List<String>> get level4Stream => _level4ListController.stream;

  StreamSink<List<String>> get level4Sink => _level4ListController.sink;

  Stream<List<Alarm>> get alarmsStream => _alarmListController.stream;

  StreamSink<List<Alarm>> get alarmsSink => _alarmListController.sink;

  Stream<List<AlarmAction>> get actionsStream => _actionListController.stream;

  StreamSink<List<AlarmAction>> get actionsSink => _actionListController.sink;

  Stream<List<ActionDone>> get actionListStream =>
      _actionsListController.stream;

  StreamSink<List<ActionDone>> get actionListSink =>
      _actionsListController.sink;

  Stream<ActionDone> get actionStream => _actionController.stream;

  StreamSink<ActionDone> get actionSink => _actionController.sink;

  Stream<AlarmDetailsResponse> get alarmDetailStream =>
      _alarmDetailsController.stream;

  StreamSink<AlarmDetailsResponse> get alarmDetailsSink =>
      _alarmDetailsController.sink;

  Stream<List<SubAction>> get subActionsStream =>
      _subActionListController.stream;

  StreamSink<List<SubAction>> get subActionsSink =>
      _subActionListController.sink;

  ProductListingProvider(this._repository) {
    _selectedDates = SelectedDates(
        fromDate: formatter.format(DateTime.now().subtract(Duration(days: 7))),
        endDate: formatter.format(DateTime.now().subtract(Duration(days: 1))));
  }

  getAllAlarms() async {
    isLoadingSink.add(true);
    alarmsSink.add(List<Alarm>());
    actionsSink.add(List<AlarmAction>());
    subActionsSink.add(List<SubAction>());
    level4Sink.add(List<String>());
    try {
      final result = await _repository.allAlarms(_authToken);
      alarmsSink.add(alarmResponseFromJson(result.data));
      isLoadingSink.add(false);
    } on DioError catch (error) {
      // Fluttertoast.showToast(
      //     msg: handleError(error),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.grey,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      alarmsSink.addError(error);
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  getActionsFromAlarm(String alarmName) async {
    isLoadingSink.add(true);
    actionsSink.add(List<AlarmAction>());
    subActionsSink.add(List<SubAction>());
    level4Sink.add(List<String>());
    _selectedAction = null;
    try {
      final result =
          await _repository.getActionsFromAlarm(_authToken, alarmName);
      actionsSink.add(actionFromJson(result.data));
      // final result1 = await _repository.updateRemarks(
      //     _authToken, _productController.value.id, _companyId, alarmName);
      // StoreStatus productStatus = storeStatusFromJson(result1.data);
      // if (productStatus.status) {
      //   productSink.add(productStatus.product);
      //   // saveAction();
      // }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error.toString());
      actionsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getSubActionFromAction(String action) async {
    isLoadingSink.add(true);
    subActionsSink.add(List<SubAction>());
    level4Sink.add(List<String>());
    _selectedSubAction = null;
    try {
      final result =
          await _repository.getSubActionsFromAction(_authToken, action);
      subActionsSink.add(subActionFromJson(result.data));
      // final result1 = await _repository.updateAction(
      //     _authToken, _productController.value.id, _companyId, action);
      // StoreStatus productStatus = storeStatusFromJson(result1.data);
      // if (productStatus.status) {
      //   productSink.add(productStatus.product);
      // }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error.toString());
      subActionsSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  getLevel4Options(String subActionName) async {
    isLoadingSink.add(true);
    level4Sink.add(List<String>());
    _selectedLevel4Option = null;
    try {
      level4Sink.add(level4DropDownList);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      level4Sink.addError(error);
      isLoadingSink.add(false);
    }
  }

  saveAction() async {
    isLoadingSink.add(true);
    try {
      final result1 = await _repository.updateRemarks(_authToken,
          _productController.value.id, _companyId, _selectedAlarm.alarmName);
      StoreStatus updateRemark = storeStatusFromJson(result1.data);
      if (updateRemark.status) {
        productSink.add(updateRemark.product);
      }
      final result2 = await _repository.updateAction(_authToken,
          _productController.value.id, _companyId, _selectedAction.action);
      StoreStatus updateAction = storeStatusFromJson(result2.data);
      if (updateAction.status) {
        productSink.add(updateAction.product);
      }
      final result = await _repository.saveAction(
        _remarks,
        _authToken,
        _productController.value.id,
      );
      StoreStatus productStatus = storeStatusFromJson(result.data);
      if (productStatus.status) {
        productSink.add(productStatus.product);
      }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      isLoadingSink.add(false);
    }
  }

  void saveDetails() async {
    isLoadingSink.add(true);
    try {
      final result1 = await _repository.updateRemarks(_authToken,
          _productController.value.id, _companyId, _selectedAlarm.alarmName);
      StoreStatus updateRemark = storeStatusFromJson(result1.data);
      if (updateRemark.status) {
        productSink.add(updateRemark.product);
      }
      final result2 = await _repository.updateAction(_authToken,
          _productController.value.id, _companyId, _selectedAction.action);
      StoreStatus updateAction = storeStatusFromJson(result2.data);
      if (updateAction.status) {
        productSink.add(updateAction.product);
      }
      final result = await _repository.saveDetails(
        _authToken,
        _productController.value.id,
        selectedSubAction.subActionName,
        _remarks,
        _barCode,
        _companyId,
      );
      StoreStatus productStatus = storeStatusFromJson(result.data);
      if (productStatus.status) {
        productSink.add(productStatus.product);
        getAllProducts();
      }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      isLoadingSink.add(false);
    }
  }

  details() async {
    try {
      final result = await _repository.details(
        _authToken,
        _companyId,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      AlarmDetailsResponse details = AlarmDetailsResponse.fromJson(result.data);
      alarmDetailsSink.add(details);
    } on DioError catch (error) {
      alarmDetailsSink.addError(error);
    }
  }

  filterStoreAlaram(String value) async {
    filterAlamListSink.add(null);

    try {
      final result = await _repository.filterAlaramStore(
        _authToken,
        value,
        _selectedDates.fromDate,
        _companyId,
        _selectedDates.endDate,
      );
      List<StoreProduct> products = storeProductsFromJson(result.data);
      filterAlamListSink.add(products);
    } on DioError catch (error) {
      filterAlamListSink.addError(error);
    }
  }

  updateRole(String productId, Roles roles) async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.updateRole(_authToken, productId, roles);
      StoreStatus productStatus = storeStatusFromJson(result.data);
      if (productStatus.status) {
        productSink.add(productStatus.product);
      }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      isLoadingSink.add(false);
    }
  }

  getAllProducts() async {
    isLoadingSink.add(true);
    productListSink.add(null);
    try {
      final result = await _repository.allProducts(
        _authToken,
        _companyId,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      productListSink.add(storeProductsFromJson(result.data));
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error.toString());
      productListSink.addError(error);
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  search() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.search(
          _companyId,
          _selectedDates.fromDate,
          _selectedDates.endDate,
          _targetId,
          _authToken);
      SeachModel search = seachModelFromJson(result.data);
      searchStateSink.add(search.alarms);
    } on DioError catch (error) {
      print(error.toString());
      searchStateSink.addError(error);
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  storeMgrActionList(String value) async {
    isLoadingSink.add(true);
    actionListSink.add(List<ActionDone>());
    try {
      final result = await _repository.flowProgres(_authToken, _userRole,
          _selectedDates.fromDate, _selectedDates.endDate, value, _companyId);
      List<ActionDone> products = actionDoneFromJson(result.data);
      actionListSink.add(products);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error);
      actionListSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  dispose() {
    super.dispose();
    _actionListController.close();
    _alarmListController.close();
    _subActionListController.close();
    _level4ListController.close();
    _loadingController.close();
    _productController.close();
    _productListController.close();
    _searchFilterController.close();
    _actionController.close();
    _actionListController.close();
    _actionsListController.close();
    _alarmDetailsController.close();
  }

  companyId(String id) {
    this._companyId = id;
  }

  setBarCode(String value) {
    _barCode = value;
  }

  setAuthTokenAndCompanyId(String token, String id) {
    this._authToken = token;
    this._companyId = id;
    //  details();
    getAllProducts();
    getAllAlarms();
    storeMgrActionList("UA");
  }

  setFromAndEndDate(SelectedDates selectedDates) {
    this._selectedDates = selectedDates;
    notifyListeners();
  }

  prodId(String value) {
    this._targetId = value;
  }
}
