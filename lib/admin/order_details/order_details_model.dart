import 'package:dio/dio.dart';
import 'package:grand_uae/admin/model/order_details_response.dart';
import 'package:grand_uae/admin/model/order_status_response.dart';
import 'package:grand_uae/admin/model/orders_response.dart';
import 'package:grand_uae/admin/model/products_order_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class AdminOrderDetailsModel extends BaseViewModel {
  final Order _order;
  final Repository _repository = locator<Repository>();
  List<Status> _orderStatuses = [];
  List<OrderProduct> _orderProducts = [];
  OrderDetails _orderDetails;
  String errorMessage = "";
  Status _status;
  Status _selectStatus;

  List<OrderProduct> get orderProducts => _orderProducts;

  set orderProducts(List<OrderProduct> value) {
    _orderProducts = value;
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

  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  OrderDetails get orderDetails => _orderDetails;

  set orderDetails(OrderDetails value) {
    _orderDetails = value;
    notifyListeners();
  }

  AdminOrderDetailsModel(this._order) {
    fetchOrderDetails();
  }

  Future fetchOrderDetails() async {
    try {
      setState(ViewState.Busy);
      var results = await Future.wait([
        _repository.adminOrderDetails(_order.orderId),
        _repository.orderProducts(_order.orderId),
        _repository.orderStatus(),
      ]);
      this.orderDetails = orderDetailsFromMap(results[0].data).success.order;
      this.orderProducts =
          orderProductsFromMap(results[1].data).success.products;
      this.orderStatuses = orderStatusFromMap(results[2].data).success.orders;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future updateStatus() async {
    if (_selectStatus == null) {
      return;
    }
    try {
      setState(ViewState.Busy);
      await _repository.updateOrderStatus(
        _order.orderId,
        _status.orderStatusId,
      );
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future<bool> deleteOrder() async {
    try {
      setState(ViewState.Busy);
      await _repository.deleteOrder(_order.orderId);

      setState(ViewState.Idle);
      return true;
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
      return false;
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
      return false;
    }
  }
}
