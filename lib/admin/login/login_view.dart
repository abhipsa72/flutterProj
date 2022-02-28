import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/admin/login/login_model.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class AdminLoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminLoginModel>(
      builder: (context, model, child) {
        return Material(
          color: Colors.grey,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 72,
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "images/grand_logo.png",
                    ),
                  ),
                ),
                Text(
                  "Admin",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        validator: userNameValidator,
                        controller: model.emailController,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: validatePassword,
                        controller: model.passwordController,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: model.obscureText,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            dragStartBehavior: DragStartBehavior.down,
                            onTap: () {
                              model.obscureText = !model.obscureText;
                            },
                            child: Icon(
                              model.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                              semanticLabel: model.obscureText
                                  ? 'show password'
                                  : 'hide password',
                            ),
                          ),
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        disabledColor: Colors.grey,
                        padding: const EdgeInsets.all(16),
                        onPressed: model.state == ViewState.Idle
                            ? () async {
                                if (_formKey.currentState.validate()) {
                                  var loginSuccess = await model.login();
                                  if (loginSuccess) {
                                    model.navigateDashboard();
                                  }
                                }
                              }
                            : null,
                        color: Theme.of(context).accentColor,
                        child: model.state == ViewState.Idle
                            ? Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.grey[600],
                                      ),
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "Loading",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      model.errorMessage != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                model.errorMessage,
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
