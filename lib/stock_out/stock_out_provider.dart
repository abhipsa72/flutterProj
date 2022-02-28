import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/stock_out/product-summary_model.dart';

class StockOutProvider extends ChangeNotifier {
  final DataManagerRepository _repository;
  final _subGroupController = BehaviorSubject<List<String>>();
  final _regionController = BehaviorSubject<List<String>>();
  final _prodSumController = BehaviorSubject<List<ProductSummary>>();
  String _authToken;

  final formatter = DateFormat('yyyy/MM/dd');
  String _selectedDate;

  String _selectedRegion;
  String _selectedStore;

  String get selectedDate => _selectedDate;

  Stream<List<String>> get regionStream => _regionController.stream;

  StreamSink<List<String>> get regionSink => _regionController.sink;

  Stream<List<String>> get subGroupStream => _subGroupController.stream;

  StreamSink<List<String>> get subGroupSink => _subGroupController.sink;

  Stream<List<ProductSummary>> get productSumStream =>
      _prodSumController.stream;

  StreamSink<List<ProductSummary>> get productSumSink =>
      _prodSumController.sink;

  String get selectedRegion => _selectedRegion;

  set setSelectedRegion(String region) {
    this._selectedRegion = region;
  }

  setStoreToNull() {
    this._selectedStore = null;
  }

  String get selectedStore => _selectedRegion;

  set setSelectedStore(String store) {
    this._selectedStore = store;
  }

  StockOutProvider(this._repository) {
    Hive.openBox(userDetailsBox).then((value) {
      _authToken = value.get(authTokenBoxKey);
    });
    _selectedDate = formatter.format(DateTime.now());
  }

  setFromAndEndDates(String selectedDate) {
    this._selectedDate = selectedDate;
    notifyListeners();
  }

  setAuthTokenAndCompanyId(String token) {
    this._authToken = token;
    // getRegion();
    stores();
    //productSummary();
  }

  // getRegion() async {
  //   regionSink.add(null);
  //   try {
  //     final result = await _repository.regions();
  //     List<String> region = (result.data as List).cast<String>();
  //     regionSink.add(region);
  //   } on DioError catch (error) {
  //     regionSink.addError(error);
  //   }
  // }

  stores() async {
    subGroupSink.add(null);
    try {
      final result = await _repository.stores();
      List<dynamic> stores = (result.data as List).cast<String>();

      subGroupSink.add(stores);
    } on DioError catch (error) {
      subGroupSink.addError(error);
    }
  }

  productSummary() async {
    productSumSink.add(List<ProductSummary>());
    try {
      final result = await _repository.productSummary(
          _selectedRegion, _selectedStore, _selectedDate);
      List<ProductSummary> productSummary = productSummaryFromJson(result.data);

      productSumSink.add(productSummary);
    } on DioError catch (error) {
      productSumSink.addError(error);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subGroupController.close();
    _regionController.close();
    _prodSumController.close();
  }
}
