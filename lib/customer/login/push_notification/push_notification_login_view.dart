import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/login/push_notification/push_notification_login_model.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class PushNotificationLoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<PushNotificationLoginModel>(
        builder: (context, model, child) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            "images/grand_logo.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          validator: validateEmail,
                          controller: model.emailController,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter email",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          validator: validatePassword,
                          controller: model.passwordController,
                          maxLines: 1,
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
                                color: Theme.of(context).iconTheme.color,
                                semanticLabel: model.obscureText
                                    ? 'show password'
                                    : 'hide password',
                              ),
                            ),
                            labelText: "Password",
                            hintText: "Enter password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MaterialButton(
                          disabledColor: Colors.grey,
                          padding: const EdgeInsets.all(16),
                          onPressed: model.state == ViewState.Idle
                              ? () async {
                                  if (_formKey.currentState.validate()) {
                                    var loginSuccess = await model.login();
                                    if (loginSuccess) {
                                      model.navigateNotification();
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
                                    fontSize: 16,
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
                                          fontSize: 16,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
