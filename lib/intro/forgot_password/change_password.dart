import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/common/intro_header_widget.dart';
import 'package:zel_app/intro/forgot_password/password_proider.dart';
import 'package:zel_app/intro/splash_screen_page.dart';

class ChangePasswordPage extends StatefulWidget {
  static var routeName = "/change_password";

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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

  _buildMobileLayout() {
    return Column(
      children: <Widget>[
        IntroHeaderWidget(
          icon: Icons.lock,
          title: "Change password",
          subTitle: "",
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
          title: "Change password",
          subTitle: "",
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: _commonControls(),
        ),
      ],
    );
  }

  _commonControls() {
    final args = ModalRoute.of<String>(context).settings.arguments;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _passwordController,
            maxLines: 1,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: "Password",
              hintText: "Enter password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            maxLines: 1,
            keyboardType: TextInputType.visiblePassword,
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
              labelText: "Confirm Password",
              hintText: "Enter confirm password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MaterialButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              final provider = Provider.of<PasswordChangeProvider>(context);
              provider.changePassword(
                  context, args, _confirmPasswordController.text);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text("Confirmation"),
                    content: Text("Going back to login to continues"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                        textColor: Theme.of(context).accentColor,
                      ),
                      MaterialButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SplashScreenPage.routeName);
                        },
                        child: Text("Ok"),
                      )
                    ],
                  );
                },
              );
            },
            child: Consumer<PasswordChangeProvider>(
              builder: (context, provider, child) {
                return provider.isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "Change password",
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
    );
  }
}
