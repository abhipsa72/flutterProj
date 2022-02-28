import 'package:dio/dio.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterModel extends BaseViewModel {
  Repository _repository = locator<Repository>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  bool _isAgree = false;
  bool _isNewsLetter = false;
  bool _obscureText = true;
  String errorMessage;

  bool get isNewsLetter => _isNewsLetter;

  set isNewsLetter(bool value) {
    _isNewsLetter = value;
    notifyListeners();
  }

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  bool get isAgree => _isAgree;

  set isAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String confirmPassword,
  ) async {
    try {
      setState(ViewState.Busy);
      if (password != confirmPassword) {
        errorMessage = "Password mismatch";
        setState(ViewState.Idle);
        return false;
      }
      if (!isAgree) {
        errorMessage = "Agree privacy policy";
        setState(ViewState.Idle);
        return false;
      }

      final result = await _repository.register(
        firstName,
        lastName,
        email,
        phone,
        password,
        confirmPassword,
        _isAgree,
        _isNewsLetter,
      );
      var isRegisterSuccess = result.data['success'] != null;
      setState(ViewState.Idle);
      return isRegisterSuccess;
    } on DioError catch (error) {
      errorMessage = error.response.data['error']['warning'];
      setState(ViewState.Idle);
      return false;
    }
  }

  Future showSuccessDialog() async {
    DialogResponse response = await _dialogService.showDialog(
      title: "Confirmation",
      description: "Registration is successful login to continue",
      buttonTitle: "Login",
      dialogPlatform: DialogPlatform.Material,
    );
    if (response.confirmed) {
      _navigationService.pushNamedAndRemoveUntil(routes.LoginRoute);
    }
  }
}
