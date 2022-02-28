import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/register/register_model.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Material(
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
          child: Container(
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Consumer<RegisterModel>(
                  builder: (_, model, child) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 56,
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "First name",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: validateName,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Last name",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: validateName,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _phoneController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: "Phone number",
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: validateMobile,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              obscureText: model.obscureText,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
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
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: validatePassword,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: validatePassword,
                              controller: _confirmPasswordController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              maxLines: 1,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: model.obscureText,
                              decoration: InputDecoration(
                                hintText: "Confirm password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Theme.of(context).accentColor,
                                  value: model.isNewsLetter,
                                  onChanged: (val) {
                                    model.isNewsLetter = val;
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Opt-in for News letter",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Theme.of(context).accentColor,
                                  value: model.isAgree,
                                  onChanged: (val) {
                                    model.isAgree = val;
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: RichText(
                                      text: TextSpan(
                                        text: "I have read and agree to the",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " Privacy Policy",
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            model.errorMessage != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model.errorMessage,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Container(),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledColor: Colors.grey,
                              padding: const EdgeInsets.all(16),
                              color: Theme.of(context).primaryColor,
                              onPressed: model.state == ViewState.Idle
                                  ? () async {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState.validate()) {
                                        var isSuccess = await model.register(
                                          _firstNameController.text,
                                          _lastNameController.text,
                                          _emailController.text,
                                          _phoneController.text,
                                          _passwordController.text,
                                          _confirmPasswordController.text,
                                        );
                                        if (isSuccess) {
                                          model.showSuccessDialog();
                                        }
                                      }
                                    }
                                  : null,
                              child: model.state == ViewState.Idle
                                  ? Text(
                                      "Register",
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
                            SizedBox(
                              height: 8,
                            ),
                            FlatButton(
                              padding: const EdgeInsets.all(16),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Have account already? Login!",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
