import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/login/login_model.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<LoginModel>(
        builder: (context, model, child) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomLeft,
                image: AssetImage("images/login-bg.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.multiply,
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.white,
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                  ),
                ),
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
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              validator: validateEmail,
                              controller: model.emailController,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Email",
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
                            GestureDetector(
                              onTap: () {
                                model.navigateForgotPassword();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.right,
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
                                          model.navigateSplash();
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            FlatButton(
                              padding: const EdgeInsets.all(16),
                              onPressed: () async {
                                model.navigateToSignUp();
                              },
                              child: Text(
                                "Don't have account? Sign Up!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
