import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/model/login_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginResponse _user;
  String _password;
  String errorMessage;
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  Future<bool> login() async {
    try {
      errorMessage = '';
      setState(ViewState.Busy);
      final result = await _repository.loginUserNamePassword(
        emailController.text,
        passwordController.text,
      );
      LoginResponse user = userFromJson(result.data);
      if (user.error == null) {
        _user = user;
        _password = passwordController.text;
        setState(ViewState.Idle);
        return true;
      } else {
        errorMessage = _user.error.message;
        setState(ViewState.Idle);
        return false;
      }
    } on DioError catch (error) {
      errorMessage = error.response.data['error']['message'];
      setState(ViewState.Idle);
      return false;
    }
  }

  Future navigateSplash() async {
    if (_user != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(apiToken, _user.success.apiToken);
      prefs.setString(userEmail, _user.success.user.email);
      prefs.setString(userPassword, _password);
      prefs.setString(userName, _user.success.user.fullName());
      prefs.setString(selectedAddressId, _user.success.user.addressId);
      prefs.setBool(isLoggedIn, true);
      _navigationService.pushNamedAndRemoveUntil(routes.SplashRoute);
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(routes.RegisterRoute);
  }

  void navigateForgotPassword() {
    _navigationService.navigateTo(routes.ForgotPasswordRoute);
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validPassword(String value) {
    if (value.length > 4) {
      return null;
    } else {
      return "Password must be more than 4 characters";
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
