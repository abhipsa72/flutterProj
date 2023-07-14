import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthenticationState{}

class Uninitialized extends AuthenticationState{}

class Loading extends AuthenticationState{}

class LoginAuthenticated extends AuthenticationState{}

class LoginUnauthenticated extends AuthenticationState{
final String error;

  LoginUnauthenticated(this.error);

}

class RegisterUnauthenticated extends AuthenticationState{
  final String error;

  RegisterUnauthenticated(this.error);

}
class Registerauthenticated extends AuthenticationState{


}


