import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/model/profile.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomerDetailsModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;

  CustomerDetailsModel();

  setUserForCurrentOrder() async {
    setState(ViewState.Busy);
    try {
      final profile = Profile(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        numberController.text,
      );
      await _repository.setUserDetailsForOrder(profile);
      setState(ViewState.Idle);
      _navigationService.navigateTo(
        routes.AddressRoute,
        arguments: profile,
      );
    } catch (error) {
      FLog.error(text: error.toString());
      setState(ViewState.Idle);
    }
  }
}
