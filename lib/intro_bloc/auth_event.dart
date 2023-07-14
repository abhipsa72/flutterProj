
import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthenticationEvent{
  AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent{

}

class LoginClicked extends AuthenticationEvent{
  final String email;
  final String password;

  LoginClicked(this.email, this.password);
}

class LogoutClicked extends AuthenticationEvent{}

class SignUpClicked extends AuthenticationEvent{
  final String email;
  final String password;
  final String name;
  final String number;

  SignUpClicked(this.email, this.password, this.name, this.number);
}

