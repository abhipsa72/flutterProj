import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/admin/model/customer_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class CustomersModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<Customer> _customerList = [];
  String errorMessage = "";

  List<Customer> get customerList => _customerList;

  set customerList(List<Customer> value) {
    _customerList = value;
    notifyListeners();
  }

  PagewiseLoadController pageLoadController = PagewiseLoadController(
    pageFuture: (int pageIndex) {
      return Future.value();
    },
    pageSize: 30,
  );

  CustomersModel() {
    pageLoadController = PagewiseLoadController(
      pageFuture: (pageIndex) => fetchCustomer(
        pageIndex + 1,
      ),
      pageSize: 30,
    );
  }

  Future<List<Customer>> fetchCustomer(page) async {
    String name = nameController.text;
    String email = emailController.text;
    var result = await _repository.customers(page, name ?? null, email ?? null);
    return customersFromMap(result.data).success.customers;
  }

  Future deleteCustomer(Customer customer) async {
    try {
      setState(ViewState.Busy);
      await _repository.deleteCustomer(customer.customerId);
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  void filterOrders() {
    pageLoadController.reset();
  }

  void clearDetails() {
    nameController.clear();
    emailController.clear();
    pageLoadController.reset();
  }
}
