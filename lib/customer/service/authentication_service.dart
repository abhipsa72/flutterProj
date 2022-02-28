import 'dart:async';

import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/model/login_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';

class AuthenticationService {
  Repository _repository = locator<Repository>();
  StreamController<LoginResponse> userController =
      StreamController<LoginResponse>();

  Future<bool> login(String email, String password) async {
    var user = await _repository.loginUserNamePassword(email, password);
    LoginResponse fetchedUser = userFromJson(user.data);
    var hasUser = fetchedUser != null;
    if (hasUser) {
      userController.add(fetchedUser);
    }
    return hasUser;
  }
}
