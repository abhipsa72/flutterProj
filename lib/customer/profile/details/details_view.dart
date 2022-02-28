import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/profile/details/details_model.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => DetailModel(),
        child: Consumer<DetailModel>(
          builder: (context, model, child) {
            if (model.state == ViewState.Busy) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (model.state == ViewState.Error) {
              return RetryButton(
                errorMessage:
                    model.errorMessage ?? "Error loading user details",
                onPressed: () {
                  model.fetchAccountDetails();
                },
              );
            }
            final PersonalDetail detail = model.detail;
            if (model.editMode == ProfileEditMode.Edit) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        validator: validateName,
                        onChanged: (val) {
                          model.firstName = val;
                        },
                        initialValue: detail.firstname,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "First name",
                          hintText: "Enter first name",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: validateLastName,
                        onChanged: (val) {
                          model.lastName = val;
                        },
                        initialValue: detail.lastname,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Last name",
                          hintText: "Enter last name",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: false,
                        validator: validateAddress,
                        onChanged: (val) {
                          model.email = val;
                        },
                        initialValue: detail.email,
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
                        validator: validateMobile,
                        onChanged: (val) {
                          model.phoneNumber = val;
                        },
                        initialValue: detail.telephone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone number",
                          hintText: "Enter phone number",
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
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (_formKey.currentState.validate()) {
                                  var success = await model.updateUserDetails();
                                  if (success) {
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                            : null,
                        child: model.state == ViewState.Idle
                            ? Text(
                                "Submit".toUpperCase(),
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
                      )
                    ],
                  ),
                ),
              );
            } else {
              return ListView(
                children: [
                  ListTile(
                    title: Text("Name"),
                    subtitle: Text(detail.fullName()),
                  ),
                  ListTile(
                    title: Text("Email"),
                    subtitle: Text(detail.email),
                  ),
                  ListTile(
                    title: Text("Phone Number"),
                    subtitle: Text(detail.telephone),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      padding: const EdgeInsets.all(16.0),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        model.editMode = ProfileEditMode.Edit;
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
