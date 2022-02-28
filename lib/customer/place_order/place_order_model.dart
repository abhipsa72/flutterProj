import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/order.dart';
import 'package:grand_uae/customer/model/order_details_response.dart';
import 'package:grand_uae/customer/model/place_order_response.dart';
import 'package:grand_uae/customer/model/send_time_slot.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class PlaceOrderModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final SelectTimeSlot _selectTimeSlot;
  Order _order;
  String errorMessage = "";
  int orderId;

  Order get order => _order;

  set orderDetails(Order value) {
    _order = value;
  }

  PlaceOrderModel(this._selectTimeSlot) {
    placeOrder();
  }

  Future fetchOrderDetails(int orderId) async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.orderDetails(orderId);
      Order order = orderDetailsFromMap(result.data).order;
      orderDetails = order;
      analytics.logEvent(
        name: useCountryCode.toUnderScore(),
        parameters: {
          'order_id': order.orderId,
          'name': order.fullName,
          'address': order.fullAddress,
        },
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

  Future placeOrder() async {
    setState(ViewState.Busy);
    try {
      var result;
      if (useCountryCode == "qatar") {
        result = await _repository.setTimeSlot(
          _selectTimeSlot.date,
          _selectTimeSlot.time,
        );
      } else {
        result = await _repository.placeOrder();
      }
      setState(ViewState.Idle);
      var orderId = placeOrderFromMap(result.data).orderId;
      this.orderId = orderId;
      fetchOrderDetails(orderId);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  void navigateToHome(CartProductModel cartModel) {
    analytics.logEvent(
      name: useCountryCode.toUnderScore(),
      parameters: {
        'order_id': order.orderId,
        'name': order.fullName,
        'address': order.fullAddress,
      },
    );
    cartModel.value.clear();
    _navigationService.pushNamedAndRemoveUntil(routes.HomePageRoute);
  }
}
