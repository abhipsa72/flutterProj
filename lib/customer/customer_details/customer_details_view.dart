import 'package:flutter/material.dart';
import 'package:grand_uae/customer/customer_details/customer_details_model.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class CustomerDetailsView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _emailNameNode = FocusNode();
  final FocusNode _phoneNameNode = FocusNode();

  _focusChange(
    BuildContext context,
    FocusNode currentNode,
    FocusNode nextFocus,
  ) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerDetailsModel>(
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("User details"),
          ),
          body: Builder(
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                focusNode: _firstNameNode,
                                onFieldSubmitted: (val) {
                                  _focusChange(
                                      context, _firstNameNode, _lastNameNode);
                                },
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Please enter name";
                                  else
                                    return null;
                                },
                                controller: model.firstNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "First name",
                                  hintText: "Enter first name",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextFormField(
                                focusNode: _lastNameNode,
                                onFieldSubmitted: (val) {
                                  _focusChange(
                                      context, _lastNameNode, _emailNameNode);
                                },
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Please enter name";
                                  else
                                    return null;
                                },
                                controller: model.lastNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Last name",
                                  hintText: "Enter last name",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _emailNameNode,
                          onFieldSubmitted: (val) {
                            _focusChange(
                                context, _emailNameNode, _phoneNameNode);
                          },
                          textInputAction: TextInputAction.next,
                          validator: validateEmail,
                          controller: model.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter email",
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          focusNode: _phoneNameNode,
                          onFieldSubmitted: (val) {
                            _phoneNameNode.unfocus();
                            _validateInputs(model);
                          },
                          textInputAction: TextInputAction.done,
                          validator: validateMobile,
                          controller: model.numberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            hintText: "Enter phone",
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MaterialButton(
                          disabledColor: Colors.grey,
                          padding: const EdgeInsets.all(16.0),
                          color: Theme.of(context).accentColor,
                          onPressed: model.state == ViewState.Idle
                              ? () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _validateInputs(model);
                                }
                              : null,
                          child: model.state == ViewState.Idle
                              ? Text(
                                  "Submit".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
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
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _validateInputs(CustomerDetailsModel model) {
    if (_formKey.currentState.validate()) {
      model.setUserForCurrentOrder();
    }
  }
}
