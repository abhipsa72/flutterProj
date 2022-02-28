import 'package:dio/dio.dart';
import 'package:f_logs/f_logs.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/model/order.dart';
import 'package:grand_uae/customer/model/order_history.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderHistoryModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  String errorMessage;
  List<Order> _orderList = [];

  List<Order> get orderList => _orderList;

  set orderList(List<Order> value) {
    _orderList = value;
    notifyListeners();
  }

  OrderHistoryModel() {
    fetchOrderHistory();
  }

  Future fetchOrderHistory() async {
    setState(ViewState.Busy);
    try {
      var result = await _repository.orderList();
      if (result.data['error'] != null) {
        errorMessage = result.data['error'];
        setState(ViewState.Error);
      } else {
        List<Order> orders = orderListFromMap(result.data).orders;
        orders.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
        this.orderList = orders;
        setState(ViewState.Idle);
      }
    } on DioError catch (error) {
      FLog.error(text: error.toString());
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  void orderDetailsView(Order order) {
    _navigationService.navigateTo(
      routes.OrderDetailsRoute,
      arguments: order,
    );
  }
}
