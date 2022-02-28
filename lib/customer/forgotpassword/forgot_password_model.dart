import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class ForgotPasswordModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  String errorMessage;

  Future sendEmail(String email) async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.forgotPasswordMail(email);
      showModel(result.data['success']);
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
}
