import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminLoginModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final emailController = TextEditingController(); //text: "admin"
  final passwordController =
      TextEditingController(); //text: "My3commercepassword"
  String errorMessage;
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  Future<bool> login() async {
    String username = emailController.text;
    String password = passwordController.text;
    setState(ViewState.Busy);
    try {
      var result = await _repository.adminLogin(username, password);

      var prefs = await SharedPreferences.getInstance();
      prefs.setString(adminLoginToken, result.data['success']['api_token']);
      setState(ViewState.Idle);
      return true;
    } on DioError catch (error) {
      errorMessage = error.response.data['error']['message'];
      setState(ViewState.Error);
      return false;
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
      return false;
    }
  }

  void navigateDashboard() {
    _navigationService.pushNamedAndRemoveUntil(routes.DashboardRoute);
  }
}
