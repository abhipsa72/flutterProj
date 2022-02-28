import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/common/intro_header_widget.dart';
import 'package:zel_app/intro/forgot_password/password_proider.dart';

class OtpVerifyPage extends StatefulWidget {
  static var routeName = "/otp_verify";
  final String _emailOrNumber;

  OtpVerifyPage(this._emailOrNumber);

  @override
  _OtpVerifyPageState createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final TextEditingController _otpController = TextEditingController();
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
          title: "OTP",
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
          title: "OTP",
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
    //final args = ModalRoute.of<String>(context).settings.arguments;
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
              validator: validateOtp,
              keyboardType: TextInputType.number,
              controller: _otpController,
              maxLines: 1,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Enter otp",
                labelText: "OTP",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                if (_otpController.value.toString().length >= 4) {
                  final provider = Provider.of<PasswordChangeProvider>(context);
                  provider.otpVerify(
                      context, widget._emailOrNumber, _otpController.text);
                }
              },
              child: Consumer<PasswordChangeProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? CircularProgressIndicator()
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

  String validateOtp(String value) {
    if (value.length >= 4) {
      return null;
    } else {
      return "Enter valid otp";
    }
  }
}
