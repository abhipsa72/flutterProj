import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class ChangePasswordModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  String password;
  String confirmPassword;
  bool _obscureText = true;
  String errorMessage;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  Future<bool> updatePassword() async {
    setState(ViewState.Busy);
    if (password == confirmPassword) {
      try {
        var result = await _repository.updatePassword(
          password,
          confirmPassword,
        );
        showModel(result.data['success']);
        setState(ViewState.Idle);
        return true;
      } on DioError catch (error) {
        errorMessage = dioError(error);
        setState(ViewState.Error);
        return false;
      } catch (error) {
        setState(ViewState.Error);
        errorMessage = error.toString();
        return false;
      }
    } else {
      showModel(
        "Password mismatch",
        color: Colors.red,
      );
      setState(ViewState.Idle);
      return false;
    }
  }
}
