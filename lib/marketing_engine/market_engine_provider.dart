import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/edit_campaign.dart';
import 'package:zel_app/model/existing_campaign.dart';
import 'package:zel_app/model/recommendationSummary.dart';
import 'package:zel_app/model/target_model.dart';
import 'package:zel_app/model/tarhet_model_status.dart';

class MarketingEngineProvider extends ChangeNotifier {
  final DataManagerRepository _repository;
  final _loadingController = BehaviorSubject<bool>();
  final _productController = BehaviorSubject<TargetModel>();
  final _productListController = BehaviorSubject<List<TargetModel>>();
  final _locationController = BehaviorSubject<List<String>>();
  final _channelController = BehaviorSubject<List<String>>();
  final _campaignController = BehaviorSubject<List<String>>();
  final _timeController = BehaviorSubject<List<String>>();
//final _filterController = BehaviorSubject<T>();
  final _existCampController = BehaviorSubject<List<ExistingCampaignModel>>();
  final _campController = BehaviorSubject<ExistingCampaignModel>();
  final _campaignListController = BehaviorSubject<List<AssociatedTargetList>>();
  final _campaignDetailController = BehaviorSubject<AssociatedTargetList>();
  final _summaryController =
      BehaviorSubject<List<RecommendationSummaryModel>>();
  final _statusController = BehaviorSubject<List<String>>();
  String _feedback;
  String _edit;

  set feedback(String value) {
    this._feedback = value;
  }

  set edit(String value) {
    this._edit = value;
    editAction(value);
  }

  TargetModel _selectedProduct;
  String _authToken;
  String _selectedLocation;
  String _selectedChannel;
  String _selectedCampaign;
  String _selectedTime;
  String _selectedStatus;
  TargetModel get product => _productController.value;

  set setProduct(TargetModel product) {
    this.productSink.add(product);
  }

  set setSelelectdProduct(TargetModel producti) {
    this._selectedProduct = producti;
  }

  ExistingCampaignModel get camp => _campController.value;

  set setCampaign(ExistingCampaignModel camp) {
    this.campSink.add(camp);
  }

  AssociatedTargetList get campList => _campaignDetailController.value;

  set setCampaignList(AssociatedTargetList camp) {
    this.campDetailSink.add(camp);
  }

  String get selectedLocation => _selectedLocation;

  set setSelectedLocation(String location) {
    this._selectedLocation = location;
  }

  String get selectedChannel => _selectedChannel;

  set setSelectedChannel(String Channel) {
    this._selectedChannel = Channel;
  }

  String get selectedCampaign => _selectedCampaign;

  set setSelectedCampaign(String Campaign) {
    this._selectedCampaign = Campaign;
  }

  String get selectedTime => _selectedTime;

  set setSelectedTime(String Time) {
    this._selectedTime = Time;
  }

  String get selectedStatus => _selectedStatus;

  set setSelectedStatus(String status) {
    this._selectedStatus = status;
    getStatus();
  }

  Stream<List<String>> get locationStream => _locationController.stream;

  StreamSink<List<String>> get locationSink => _locationController.sink;

  Stream<List<String>> get channelStream => _channelController.stream;

  StreamSink<List<String>> get channelSink => _channelController.sink;

  Stream<List<String>> get campaignStream => _campaignController.stream;

  StreamSink<List<String>> get campaignSink => _campaignController.sink;

  Stream<List<String>> get timePeriodStream => _timeController.stream;

  StreamSink<List<String>> get timePeriodSink => _timeController.sink;

  Stream<List<String>> get customerStatusStream => _statusController.stream;

  StreamSink<List<String>> get customerStatusSink => _statusController.sink;

  Stream<List<TargetModel>> get productListStream =>
      _productListController.stream;

  StreamSink<List<TargetModel>> get productListSink =>
      _productListController.sink;

  Stream<List<ExistingCampaignModel>> get existCampStream =>
      _existCampController.stream;

  StreamSink<List<ExistingCampaignModel>> get existCampSink =>
      _existCampController.sink;

  // Stream<List<TargetModel>> get filterListStream =>
  //     _filterController.stream;
  //
  // StreamSink<List<TargetModel>> get filterListSink =>
  //     _productListController.sink;

  Stream<TargetModel> get productStream => _productController.stream;

  StreamSink<TargetModel> get productSink => _productController.sink;

  Stream<ExistingCampaignModel> get campStream => _campController.stream;

  StreamSink<ExistingCampaignModel> get campSink => _campController.sink;

  Stream<List<AssociatedTargetList>> get asscociatCampStream =>
      _campaignListController.stream;

  StreamSink<List<AssociatedTargetList>> get asscociatCampSink =>
      _campaignListController.sink;

  Stream<AssociatedTargetList> get campDetailStream =>
      _campaignDetailController.stream;

  StreamSink<AssociatedTargetList> get campDetailSink =>
      _campaignDetailController.sink;

  Stream<List<RecommendationSummaryModel>> get summaryStream =>
      _summaryController.stream;

  StreamSink<List<RecommendationSummaryModel>> get summarySink =>
      _summaryController.sink;

  MarketingEngineProvider(this._repository);

  getLocation() async {
    locationSink.add(null);
    locationSink.add(List<String>());
    try {
      final result = await _repository.getLocation(_authToken);
      List<String> roles = (result.data as List).cast<String>();
      if (roles.isNotEmpty) {
        locationSink.add(roles);
      } else {
        locationSink.addError("No data");
      }
    } on DioError catch (error) {
      locationSink.addError(error);
    }
  }

  getChannel() async {
    channelSink.add(null);
    channelSink.add(List<String>());
    try {
      final result = await _repository.getChannel(_authToken);
      List<String> roles = (result.data as List).cast<String>();
      if (roles.isNotEmpty) {
        channelSink.add(roles);
      } else {
        channelSink.addError("No data");
      }
    } on DioError catch (error) {
      channelSink.addError(error);
    }
  }

  getCampaign() async {
    campaignSink.add(null);
    campaignSink.add(List<String>());
    try {
      final result = await _repository.getCampaign(_authToken);
      List<String> campaign = (result.data as List).cast<String>();
      if (campaign.isNotEmpty) {
        campaignSink.add(campaign);
      } else {
        campaignSink.addError("No data");
      }
    } on DioError catch (error) {
      campaignSink.addError(error);
    }
  }

  getTimePeriod() async {
    timePeriodSink.add(List<String>());
    try {
      final result = await _repository.timePeriod(_authToken);
      List<String> time = (result.data as List).cast<String>();
      if (time.isNotEmpty) {
        timePeriodSink.add(time);
      } else {
        timePeriodSink.addError("No data");
      }
    } on DioError catch (error) {
      timePeriodSink.addError(error);
    }
  }

  Stream<bool> get isLoading => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;

  targetListApi() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.targetListApi(_authToken);
      List<TargetModel> products = targetModelFromJson(result.data);
      productListSink.add(products);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  filterTargetList() async {
    isLoadingSink.add(true);
    productListSink.add(List<TargetModel>());
    try {
      final result = await _repository.filterTargetList(
          _authToken,
          _selectedLocation,
          _selectedChannel,
          _selectedTime,
          _selectedCampaign);
      TargetListStatus products = targetListStatusFromJson(result.data);
      productListSink.add(products.targetModel);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      isLoadingSink.add(false);
    }
  }

  createActionlist(String name, String targetlistIds) async {
    try {
      final result = await _repository.createAction(
          _authToken, _selectedTime, name, targetlistIds);
    } on DioError catch (error) {
      debugPrint("$error");
      isLoadingSink.add(false);
    }
  }

  existingCampaign() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.existingCampaign(_authToken);
      List<ExistingCampaignModel> campaigns =
          existingCampaignModelFromJson(result.data);
      existCampSink.add(campaigns);

      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  recommandationSummary() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.recomSummary(_authToken, _selectedTime);
      List<RecommendationSummaryModel> summary =
          recommendationSummaryFromJson(result.data);
      summarySink.add(summary);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  deleteActionList(String id) async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.deleteCampaign(_authToken, id);
      if (result.statusCode == 200) {
        existingCampaign();
      }
    } on DioError catch (error) {
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  editCampaign(String id, String newName) async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.editAction(_authToken, newName, id);
      EditCampaignModel editCampaignModel =
          editCampaignModelFroJson(result.data);
      if (editCampaignModel.status) {
        campSink.add(editCampaignModel.actionList);
        existingCampaign();
      }
      Fluttertoast.showToast(
          msg: editCampaignModel.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error.toString());
      isLoadingSink.add(false);
    }
  }

  getStatus() async {
    isLoadingSink.add(true);
    customerStatusSink.add(List<String>());
    try {
      final result = await _repository.customerStatus(_authToken);
      List<String> status = (result.data as List).cast<String>();
      if (status.isNotEmpty) {
        customerStatusSink.add(status);
      }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      customerStatusSink.addError(error);
      isLoadingSink.add(false);
    }
  }

  saveDetails(String id, String actionId) async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.agentFeedbak(
        _authToken,
        actionId,
        id,
        _feedback,
        _selectedStatus,
      );
      if (result.statusCode == 200) {
        existingCampaign();
      }
      isLoadingSink.add(false);
    } on DioError catch (error) {
      print(error);
      isLoadingSink.add(false);
    }
  }

  void refresh() {
    notifyListeners();
    existingCampaign();
  }

  chechedBox() {
    notifyListeners();
    targetListApi();
    //createActionlist(this.name, targetlistIds)
  }

  setAuthToken(String token) {
    this._authToken = token;
    targetListApi();
    getChannel();
    getLocation();
    getCampaign();
    getTimePeriod();
  }

  setToken(String token) {
    this._authToken = token;
    existingCampaign();
    getStatus();
  }

  setTokenAgent(String token) {
    this._authToken = token;
    existingCampaign();
    getStatus();
  }

  setTokenForSummary(String token) {
    this._authToken = token;
    recommandationSummary();
  }

  agentFeedback(String value) {
    this._feedback = value;
  }

  editAction(String value) {
    this._edit = value;
  }

  dispose() {
    super.dispose();
    _productController.close();
    _loadingController.close();
    _productListController.close();
    _channelController.close();
    _locationController.close();
    _campaignController.close();
    _timeController.close();
    _existCampController.close();
    _campaignListController.close();
    _campaignDetailController.close();
    _statusController.close();
  }
}
