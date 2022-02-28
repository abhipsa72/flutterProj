import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/payment_methods.dart';
import 'package:grand_uae/customer/model/send_time_slot.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class ChoosePaymentViewModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  List<PaymentMethod> _paymentMethods = [];
  PaymentMethod _selectedPayment;
  bool isEnableButton = false;
  String errorMessage;

  PaymentMethod get selectedPayment => _selectedPayment;

  set selectedPayment(PaymentMethod value) {
    _selectedPayment = value;
    notifyListeners();
  }

  List<PaymentMethod> get paymentMethods => _paymentMethods;

  set paymentMethods(List<PaymentMethod> value) {
    _paymentMethods = value;
    notifyListeners();
  }

  ChoosePaymentViewModel() {
    fetchPaymentMethods();
  }

  Future fetchPaymentMethods() async {
    setState(ViewState.Busy);
    try {
      final result = await _repository.paymentMethods();
      var payments = paymentMethodsFromJson(result.data).paymentMethods;
      paymentMethods = payments;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      setState(ViewState.Error);
      errorMessage = dioError(error);
      showModel(dioError(error), color: Colors.red);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      showModel(error.toString(), color: Colors.red);
    }
  }

  Future setPaymentMethod() async {
    setState(ViewState.Busy);
    try {
      await _repository.setPaymentMethod(_selectedPayment.code);
      setState(ViewState.Idle);
      if (useCountryCode == "qatar") {
        _navigationService.navigateTo(routes.TimeSlotRoute);
      } else {
        _navigationService.navigateTo(
          routes.PlaceOrderRoute,
          arguments: SelectTimeSlot(),
        );
      }
    } on DioError catch (error) {
      setState(ViewState.Error);
      errorMessage = dioError(error);
      showModel(dioError(error), color: Colors.red);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      showModel(error.toString(), color: Colors.red);
    }
  }
}
