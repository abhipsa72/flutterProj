import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/common/intro_header_widget.dart';
import 'package:zel_app/intro/register/register_provider.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = "/register_page";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
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

  _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IntroHeaderWidget(
          icon: Icons.account_circle,
          title: "Register",
          subTitle: "Create a new ZEL app account!",
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: _commonWidgets(),
        )
      ],
    );
  }

  _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          IntroHeaderWidget(
            icon: Icons.account_circle,
            title: "Register",
            subTitle: "Create a new ZEL app account!",
          ),
          SizedBox(
            height: 16,
          ),
          _commonWidgets()
        ],
      ),
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validPassword(String value) {
    if (value.length > 4) {
      return null;
    } else {
      return "Password must be more than 4 characters";
    }
  }

  _commonWidgets() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: validateName,
              controller: _nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Enter full name",
                labelText: "Full name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: validateEmail,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Enter email",
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: validateMobile,
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Enter phone number",
                labelText: "Phone number",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: validPassword,
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              maxLines: 1,
              obscureText: _obscureText,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).iconTheme.color,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Enter password",
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Consumer<RegisterProvider>(
              builder: (_, provider, child) {
                return MaterialButton(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      provider.registerNewAccount(
                          context,
                          _nameController.text,
                          _emailController.text,
                          _phoneNumberController.text,
                          _passwordController.text);
                    }
                  },
                  child: provider.isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
