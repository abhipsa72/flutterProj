import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/common/intro_header_widget.dart';
import 'package:zel_app/intro/forgot_password/password_proider.dart';

class ForgotPasswordPage extends StatefulWidget {
  static var routeName = "/forgot_password";

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailNumberController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape
              ? _buildTabletLayout()
              : _buildMobileLayout();
        },
      ),
    );
  }

  _buildMobileLayout() {
    return Column(
      children: <Widget>[
        IntroHeaderWidget(
          icon: Icons.lock,
          title: "Forgot password",
          subTitle: "Don't worry we got you!",
        ),
        SizedBox(
          height: 16,
        ),
        _commonControls()
      ],
    );
  }

  _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IntroHeaderWidget(
          icon: Icons.lock,
          title: "Forgot password",
          subTitle: "Don't worry we got you!",
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: _commonControls(),
        ),
      ],
    );
  }

  _commonControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: validateEmailOrNumber,
              keyboardType: TextInputType.emailAddress,
              controller: _emailNumberController,
              maxLines: 1,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Enter email or number",
                labelText: "Email or Number",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final provider = Provider.of<PasswordChangeProvider>(context,
                      listen: false);
                  provider.forgotPassword(context, _emailNumberController.text);
                }
              },
              child: Consumer<PasswordChangeProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                },
              ),
              padding: const EdgeInsets.all(16),
            )
          ],
        ),
      ),
    );
  }

  String validateEmailOrNumber(String value) {
    if (value.length > 4) {
      return null;
    } else {
      return "Enter valid email or number";
    }
  }
}
