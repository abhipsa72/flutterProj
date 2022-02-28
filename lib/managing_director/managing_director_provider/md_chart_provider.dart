import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/bar_chart_md.dart';
import 'package:zel_app/model/line_chart_response.dart';
import 'package:zel_app/model/role_details.dart';
import 'package:zel_app/model/saled_impact_chart.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/util/dio_network.dart';

class ManagingDirectorChart extends ChangeNotifier {
  final _rolesController = BehaviorSubject<List<String>>();
  final _regionController = BehaviorSubject<List<String>>();
  final _roleDetailsController = BehaviorSubject<RoleDetails>();
  final _lineChartController = BehaviorSubject<LineChartResponse>();
  final _barChartController = BehaviorSubject<DepartmentSales>();
  final _salesImpactChartController = BehaviorSubject<SalesImpact>();
  final _storeController = BehaviorSubject<List<String>>();

  final DataManagerRepository _repository;
  ManagingDirectorProvider _mdprovider;
  ManagingDirectorProvider get provider => _mdprovider;

  final _loadingController = BehaviorSubject<bool>();
  final formatter = DateFormat('dd/MM/yyyy');
  ApiState _apiState = ApiState.WithRegion;

  SelectedDates _selectedDates = SelectedDates();
  String _authToken;
  String _companyId;
  String _selectedStore;
  String _selectedRole;
  String _selectedRegion;

  ManagingDirectorChart(this._repository) {
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

  setFromAndEndDatesCharts(ManagingDirectorProvider provider) {
    this._mdprovider = provider;
    notifyListeners();
  }

  setStoreToNull() {
    this._selectedStore = null;
  }

  Stream<bool> get isLoadingStream => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;

  Stream<List<String>> get storeListStream => _storeController.stream;

  StreamSink<List<String>> get storeListSink => _storeController.sink;
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

  ineChartForManagingDirector() async {
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
}
