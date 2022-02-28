import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/admin/enums/sort_with_order.dart';
import 'package:grand_uae/admin/model/order_status_response.dart';
import 'package:grand_uae/admin/model/orders_response.dart';
import 'package:grand_uae/admin/orders/filter_orders.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class OrdersModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController amountController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController dateAddedController = TextEditingController();
  TextEditingController dateModifiedController = TextEditingController();
  List<Order> _orders = [];
  List<Status> _orderStatuses = [];
  String errorMessage = "";
  Status _selectStatus;
  SortWithAdminOrder _sortWithAdminOrder = SortWithAdminOrder.Default;

  SortWithAdminOrder get sortWithAdminOrder => _sortWithAdminOrder;

  set sortWithAdminOrder(SortWithAdminOrder value) {
    _sortWithAdminOrder = value;
    notifyListeners();
  }

  Status get selectStatus => _selectStatus;

  set selectStatus(Status value) {
    _selectStatus = value;
    notifyListeners();
  }

  List<Status> get orderStatuses => _orderStatuses;

  set orderStatuses(List<Status> value) {
    _orderStatuses = value;
    notifyListeners();
  }

  List<Order> get orders => _orders;

  set orders(List<Order> value) {
    _orders = value;
    notifyListeners();
  }

  PagewiseLoadController pageLoadController = PagewiseLoadController(
    pageFuture: (int pageIndex) {
      return Future.value();
    },
    pageSize: 30,
  );

  OrdersModel() {
    fetchDetails();
    pageLoadController = PagewiseLoadController(
      pageFuture: (pageIndex) => filterOrders(
        pageIndex + 1,
      ),
      pageSize: 30,
    );
  }

  Future fetchDetails() async {
    try {
      setState(ViewState.Busy);
      var results = await Future.wait([
        _repository.orderStatus(),
      ]);

      this.orderStatuses = orderStatusFromMap(results[0].data).success.orders;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future<List<Order>> filterOrders(int page) async {
    String customer = customerController.text;
    String amount = amountController.text;

    var results = await _repository.orders(
      FilterOrders(
        orderStatusId: _selectStatus?.orderStatusId ?? null,
        customer: customer,
        amount: amount,
        page: page,
        dateAdded: dateAddedController.text,
        dateModified: dateModifiedController.text,
      ),
      sortMap.reverse[_sortWithAdminOrder],
    );
    return ordersFromMap(results.data).success.orders;
  }

  void orderDetails(Order order) {
    _navigationService.navigateTo(
      routes.AdminOrderDetailsRoute,
      arguments: order,
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future clearFilterOrders() async {
    amountController.clear();
    customerController.clear();

    try {
      setState(ViewState.Busy);
      var results = await _repository.orders(FilterOrders(), null);
      this.orders = ordersFromMap(results.data).success.orders;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }
}

var sortMap = EnumValues<SortWithAdminOrder>({
  'o.order_id&order=ASC': SortWithAdminOrder.OrderId,
  'o.order_id&order=DESC': SortWithAdminOrder.OrderIdDesc,
  'customer&order=ASC': SortWithAdminOrder.Customer,
  'customer&order=DESC': SortWithAdminOrder.CustomerDesc,
  'order_status&order=ASC': SortWithAdminOrder.Status,
  'order_status&order=DESC': SortWithAdminOrder.StatusDesc,
  'o.total&order=ASC': SortWithAdminOrder.Total,
  'o.total&order=DESC': SortWithAdminOrder.TotalDesc,
  'o.date_added&order=ASC': SortWithAdminOrder.DateAdded,
  'o.date_added&order=DESC': SortWithAdminOrder.DateAddedDesc,
  'o.date_modified&order=ASC': SortWithAdminOrder.DateAdded,
  'o.date_modified&order=DESC': SortWithAdminOrder.DateAddedDesc,
});
