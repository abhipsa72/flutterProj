import 'package:flutter/material.dart';
import 'package:grand_uae/customer/forgotpassword/forgot_password_model.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ForgotPasswordModel>(
          builder: (_, model, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Enter the e-mail address associated with your account. Click submit to have a password reset link e-mailed to you.",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    controller: _emailController,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  model.errorMessage != null
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(model.errorMessage),
                          ),
                        )
                      : Container(),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    disabledColor: Colors.grey,
                    padding: const EdgeInsets.all(16),
                    onPressed: model.state == ViewState.Idle
                        ? () async {
                            if (_formKey.currentState.validate()) {
                              model.sendEmail(_emailController.text);
                            }
                          }
                        : null,
                    color: Theme.of(context).accentColor,
                    child: model.state == ViewState.Idle
                        ? Text(
                            "Submit",
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
