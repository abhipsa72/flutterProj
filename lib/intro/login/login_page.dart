import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/intro/forgot_password/forgot_password_page.dart';
import 'package:zel_app/intro/login/login_provider.dart';
import 'package:zel_app/intro/register/register_page.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/util/enum_values.dart';
import 'package:zel_app/views/NoInternet.dart';

class LoginPage extends StatefulWidget {
  static var routeName = "/login_page";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  LoginResponse response;
  //final languagesBox = Hive.box(languagesBoxName);

  var _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _repository = Provider.of<DataManagerRepository>(context);

    return ChangeNotifierProvider(
      create: (context) => LoginProvider(_repository),
      child: Consumer<ConnectivityStatus>(builder: (_, value, child) {
        if (value == ConnectivityStatus.Offline) {
          return NoInternet();
        }
        return Scaffold(
          body: _buildMobileLayout(),
          // body: OrientationBuilder(
          //   builder: (_, orientation) {
          //     return orientation == Orientation.landscape
          //         ? _buildTabletLayout()
          //         : _buildMobileLayout();
          //   },
          // ),
        );
      }),
    );
  }

  _buildMobileLayout() {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.orange[800],
              Colors.orange[800],
              Colors.orange[800]
            ])),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    // color: Theme.of(context).primaryColor,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/zedeye_logo.png",
                            height: 150,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Where inovation begins",
                              style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .fontSize,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // width: MediaQuery.of(context).size.width / 3,

                  inputWidgets()
                ],
              ),
            )));
  }

  _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/zedeye_logo.png",
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Where inovation begins",
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: Theme.of(context).textTheme.headline4.fontSize,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(child: inputWidgets())))
      ],
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validPassword(String value) {
    if (value.length > 4) {
      return null;
    } else {
      return "Password must be more than 4 characters";
    }
  }

//  showAlert(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (_) {
//        return AlertDialog(
//          title: Text("Success"),
//          // content: Text("Registeration successful please continue loign"),
//
//        );
//      },
//    );
//  }
//   inputWidgets() {
//     return Padding(
//       padding: MediaQuery.of(context).size.width <= 600
//           ? const EdgeInsets.all(30)
//           : const EdgeInsets.all(50),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FadeAnimation(
//                 1.4,
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color.fromRGBO(225, 95, 27, .3),
//                             blurRadius: 20,
//                             offset: Offset(0, 10))
//                       ]),
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.grey[200]))),
//                         child: TextFormField(
//                           validator: validateEmail,
//                           keyboardType: TextInputType.emailAddress,
//                           controller: _emailController,
//                           maxLines: 1,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter email",
//                             labelText: "Email",
//                             prefixIcon: Icon(Icons.email),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.grey[200]))),
//                         child: TextFormField(
//                           validator: validPassword,
//                           controller: _passwordController,
//                           maxLines: 1,
//                           keyboardType: TextInputType.visiblePassword,
//                           obscureText: _obscureText,
//                           decoration: InputDecoration(
//                             suffixIcon: GestureDetector(
//                               dragStartBehavior: DragStartBehavior.down,
//                               onTap: () {
//                                 setState(() {
//                                   _obscureText = !_obscureText;
//                                 });
//                               },
//                               child: Icon(
//                                 _obscureText
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Theme.of(context).iconTheme.color,
//                                 semanticLabel: _obscureText
//                                     ? 'show password'
//                                     : 'hide password',
//                               ),
//                             ),
//                             border: InputBorder.none,
//                             labelText: "Password",
//                             hintText: "Enter password",
//                             prefixIcon: Icon(Icons.lock),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             SizedBox(
//               height: 40,
//             ),
//
//             // SizedBox(
//             //   height: 16,
//             // ),
//             //
//             // SizedBox(
//             //   height: 16,
//             // ),
//             Consumer<LoginProvider>(
//               builder: (_, provider, __) {
//                 return MaterialButton(
//                   padding: const EdgeInsets.all(16),
//                   onPressed: () {
//                     if (_formKey.currentState.validate()) {
//                       provider.loginUser(context, _emailController.text,
//                           _passwordController.text);
//                     }
//                   },
//                   child: Consumer<LoginProvider>(
//                     builder: (context, provider, view) {
//                       return provider.isLoading
//                           ? CircularProgressIndicator(
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(Colors.white),
//                             )
//                           : Text(
//                               "Login",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             );
//                     },
//                   ),
//                   color: Theme.of(context).accentColor,
//                 );
//               },
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   child: FadeAnimation(
//                     1.5,
//                     new InkWell(
//                         child: new Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                             color: Colors.black54,
//                             fontSize: 17,
//                           ),
//                         ),
//                         onTap: () => Navigator.of(context)
//                             .pushNamed(ForgotPasswordPage.routeName)),
//                   ),
//                 ),
//                 SizedBox(width: 50),
//                 Expanded(
//                     child: FadeAnimation(
//                   1.5,
//                   FlatButton(
//                     padding: const EdgeInsets.all(16),
//                     onPressed: () async {
//                       Navigator.of(context).pushNamed(RegisterPage.routeName);
//                     },
//                     child: Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.lightBlueAccent,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   // MaterialButton(
//                   //   color: Theme.of(context).accentColor,
//                   //   padding: const EdgeInsets.all(16),
//                   //   onPressed: () {
//                   //     Navigator.of(context).pushNamed(RegisterPage.routeName);
//                   //   },
//                   //   child: Text(
//                   //     "Register",
//                   //     style: TextStyle(
//                   //       color: Colors.white,
//                   //       fontWeight: FontWeight.bold,
//                   //     ),
//                   //   ),
//                   // ),
//                 ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
  inputWidgets() {
    return Padding(
      padding: MediaQuery.of(context).size.width <= 600
          ? const EdgeInsets.all(30)
          : const EdgeInsets.all(50),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter email",
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                        hintStyle: kHintTextStyle,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      validator: validPassword,
                      controller: _passwordController,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscureText,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).iconTheme.color,
                            semanticLabel: _obscureText
                                ? 'show password'
                                : 'hide password',
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Enter password",
                        hintStyle: kHintTextStyle,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(ForgotPasswordPage.routeName),
                padding: EdgeInsets.only(right: 0.0),
                child: Text(
                  'Forgot Password?',
                  style: kLabelStyle,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Consumer<LoginProvider>(
              builder: (_, provider, __) {
                return MaterialButton(
                  padding: const EdgeInsets.all(16),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      provider.loginUser(context, _emailController.text,
                          _passwordController.text);
                    }
                  },
                  child: Consumer<LoginProvider>(
                    builder: (context, provider, view) {
                      return provider.isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.orange),
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            );
                    },
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                );
              },
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => print('Sign Up Button Pressed'),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an Account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context)
                                  .pushNamed(RegisterPage.routeName))
                      ],
                    ),
                  ),
                ))
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Expanded(
            //       child: FadeAnimation(
            //         1.5,
            //         new InkWell(
            //             child: new Text(
            //               'Forgot Password?',
            //               style: TextStyle(
            //                 color: Colors.black54,
            //                 fontSize: 17,
            //               ),
            //             ),
            //             onTap: () => Navigator.of(context)
            //                 .pushNamed(ForgotPasswordPage.routeName)),
            //       ),
            //     ),
            //     SizedBox(width: 50),
            //     Expanded(
            //         child: FadeAnimation(
            //       1.5,
            //       FlatButton(
            //         padding: const EdgeInsets.all(16),
            //         onPressed: () async {
            //           Navigator.of(context).pushNamed(RegisterPage.routeName);
            //         },
            //         child: Text(
            //           "Sign Up",
            //           style: TextStyle(
            //             color: Colors.lightBlueAccent,
            //             fontSize: 18,
            //           ),
            //         ),
            //       ),
            //     ))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

final kHintTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
