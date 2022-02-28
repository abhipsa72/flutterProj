import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zel_app/common/loading.dart';
import 'package:zel_app/intro/login/login_page.dart';
import 'package:zel_app/managers/repository.dart';

class RegisterProvider extends Loading {
  DataManagerRepository _repository;

  RegisterProvider(this._repository);

  registerNewAccount(BuildContext context, String fullName, String email,
      String phoneNumber, String password) async {
    setLoading(true);
    try {
      final result = await _repository.registerAccount(
          fullName, email, phoneNumber, password);
      if (result.statusCode == 200) {
        showDialogContinueLogin(context);
      }
      setLoading(false);
    } on DioError catch (error) {
      debugPrint("$error");
      setLoading(false);
    }
  }

  void showDialogContinueLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Registeration successful please continue loign"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginPage.routeName, (route) => false);
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
