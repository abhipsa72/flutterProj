import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/profile/change_password/change_password_model.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordModel(),
      child: Consumer<ChangePasswordModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Change password"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    onChanged: (val) {
                      model.password = val;
                    },
                    obscureText: model.obscureText,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        dragStartBehavior: DragStartBehavior.down,
                        onTap: () {
                          model.obscureText = !model.obscureText;
                        },
                        child: Icon(
                          model.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          semanticLabel: model.obscureText
                              ? 'show password'
                              : 'hide password',
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      model.confirmPassword = val;
                    },
                    validator: validatePassword,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: model.obscureText,
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    disabledColor: Colors.grey,
                    color: Theme.of(context).accentColor,
                    padding: const EdgeInsets.all(16.0),
                    onPressed: model.state == ViewState.Idle
                        ? () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState.validate()) {
                              var success = await model.updatePassword();
                              if (success) {
                                Navigator.of(context).pop(true);
                              }
                            }
                          }
                        : null,
                    child: model.state == ViewState.Idle
                        ? Text(
                            "Update password".toUpperCase(),
                            style: TextStyle(),
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
            ),
          ),
        ),
      ),
    );
  }
}
