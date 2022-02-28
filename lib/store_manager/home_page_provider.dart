import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zel_app/common/loading.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/bar_chart_response.dart';
import 'package:zel_app/model/bobble_chart_response.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/model/line_chart_response.dart';
import 'package:zel_app/model/pie_chart_response.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/util/dio_network.dart';

class ChartsProvider extends Loading {
  final DataManagerRepository _repository;
  final _detailsController = BehaviorSubject<AlarmDetailsResponse>();
  final _barChartController = BehaviorSubject<BarChartResponse>();
  final _pieChartController = BehaviorSubject<PieChartResponse>();
  final _lineCharController = BehaviorSubject<LineChartResponse>();
  final _bubbleChartController = BehaviorSubject<BubbleChartResponse>();
  final _departmentController = BehaviorSubject<List<String>>();
  final _loadingController = BehaviorSubject<bool>();
  String _selectedDepartment;
  String get selectedDepartment => _selectedDepartment;
  // set setSelectedDepartmentInLine(String department) {
  //   this._selectedDepartment = department;
  //   setDepartmentLine(selectedDepartment);
  // }

  final formatter = DateFormat('dd/MM/yyyy');

  Stream<bool> get isLoadingStream => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;
  Stream<AlarmDetailsResponse> get alarmDetailsStream =>
      _detailsController.stream;

  StreamSink<AlarmDetailsResponse> get alarmDetailsSink =>
      _detailsController.sink;

  Stream<BarChartResponse> get barChartStream => _barChartController.stream;

  StreamSink<BarChartResponse> get barChartSink => _barChartController.sink;

  Stream<PieChartResponse> get pieChartStream => _pieChartController.stream;

  StreamSink<PieChartResponse> get pieChartSink => _pieChartController.sink;

  Stream<List<String>> get departmentListStream => _departmentController.stream;

  StreamSink<List<String>> get departmentListSink => _departmentController.sink;

  Stream<LineChartResponse> get lineChartStream => _lineCharController.stream;

  StreamSink<LineChartResponse> get lineChartSink => _lineCharController.sink;

  Stream<BubbleChartResponse> get bubbleChartStream =>
      _bubbleChartController.stream;

  StreamSink<BubbleChartResponse> get bubbleChartSink =>
      _bubbleChartController.sink;

  dispose() {
    super.dispose();
    _bubbleChartController.close();
    _lineCharController.close();
    _detailsController.close();
    _barChartController.close();
    _pieChartController.close();
  }

  String _authToken;
  String _companyId;

  SelectedDates _selectedDates = SelectedDates();
  SelectedDates get selectedDates => _selectedDates;

  ChartsProvider(this._repository) {
    _selectedDates = SelectedDates(
        fromDate: formatter.format(DateTime.now().subtract(Duration(days: 7))),
        endDate: formatter.format(DateTime.now().subtract(Duration(days: 1))));
  }

  setAuthTokenAndCompanyId(String token, String id) {
    this._authToken = token;
    this._companyId = id;
    details();
    barChartDetails();
    pieChartsDetails();
    lineChartDetails();
    // getDepartments();
    bubbleChartDetails();
    //setDepartmentLine(selectedDepartment);
    //setDepartmentDonught(selectedDepartment);
  }

  setFromAndEndDate(SelectedDates selectedDates) {
    this._selectedDates = selectedDates;
    notifyListeners();
  }

  details() async {
    try {
      final result = await _repository.details(
        _authToken,
        _companyId,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      if (result.statusCode == 200) {
        AlarmDetailsResponse details =
            AlarmDetailsResponse.fromJson(result.data);
        alarmDetailsSink.add(details);
      }
    } on DioError catch (error) {
      print(error.toString());
      alarmDetailsSink.addError(error);
    }
  }

  barChartDetails() async {
    try {
      final result = await _repository.barChartDetails(
        _authToken,
        _companyId,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      if (result.statusCode == 200) {
        BarChartResponse response = barChartResponseFromJson(result.data);
        barChartSink.add(response);
      }
    } on DioError catch (error) {
      barChartSink.addError(error);
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  pieChartsDetails() async {
    try {
      final result = await _repository.pieChartsDetails(
        _authToken,
        _companyId,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      if (result.statusCode == 200) {
        PieChartResponse response = PieChartResponse.fromMap(result.data);
        pieChartSink.add(response);
      }
    } on DioError catch (error) {
      pieChartSink.addError(error);
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  lineChartDetails() async {
    try {
      final result = await _repository.lineChartDetails(
        _authToken,
        _companyId,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      if (result.statusCode == 200) {
        LineChartResponse response = lineChartResponseFromJson(result.data);
        lineChartSink.add(response);
      }
      // if (result.statusCode == 403) {
      //   Container();
      // }
    } on DioError catch (error) {
      lineChartSink.addError(error);
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
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

  // setDepartmentLine(String deptName) async {
  //   isLoadingSink.add(true);
  //   print(_companyId);
  //   try {
  //     final result = await _repository.lineChartFilter(
  //         authToken: _authToken,
  //         fromDate: _selectedDates.fromDate,
  //         endDate: _selectedDates.endDate,
  //         companyId: _companyId,
  //         value: deptName);
  //     LineChartResponse response = lineChartResponseFromJson(result.data);
  //     lineChartSink.add(response);
  //     isLoadingSink.add(false);
  //   } on DioError catch (error) {
  //     isLoadingSink.add(false);
  //   }
  // }

  bubbleChartDetails() async {
    try {
      final result = await _repository.bubbleChartDetails(
        _authToken,
        _companyId,
        _selectedDates.fromDate,
        _selectedDates.endDate,
      );
      if (result.statusCode == 200) {
        BubbleChartResponse response = bubbleChartResponseFromJson(result.data);
        bubbleChartSink.add(response);
      }
    } on DioError catch (error) {
      bubbleChartSink.addError(error);
      Fluttertoast.showToast(
          msg: handleError(error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
