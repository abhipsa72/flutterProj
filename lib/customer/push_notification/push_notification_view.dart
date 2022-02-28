import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/model/login_country.dart';
import 'package:grand_uae/customer/model/push_notification_type.dart';
import 'package:grand_uae/customer/push_notification/push_notification_model.dart';
import 'package:provider/provider.dart';

class PushNotificationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<PushNotificationModel>(
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Push notification"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Consumer<PushNotificationModel>(
                      builder: (_, value, child) {
                        if (value.countries.isEmpty) {
                          return Container();
                        }
                        return DropdownButtonFormField<LoginCountry>(
                          value: value.country,
                          hint: Text("Select country"),
                          decoration: InputDecoration(
                            labelText: "Country",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: value.countries.values
                              .map(
                                (e) => DropdownMenuItem<LoginCountry>(
                                  child: Text(e.name),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            value.country = val;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    DropdownButtonFormField<PushNotificationType>(
                      value: model.type,
                      hint: Text("Select type"),
                      decoration: InputDecoration(
                        labelText: "Notification type",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: model.pushNotificationTypes
                          .map(
                            (e) => DropdownMenuItem<PushNotificationType>(
                              child: Text(e.name),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        model.type = val;
                        if (val.type == 'product_id') {
                          model.isProductInput = true;
                        } else {
                          model.isProductInput = false;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Consumer<PushNotificationModel>(
                      builder: (_, value, child) {
                        if (value.isProductInput) {
                          return TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val.isEmpty)
                                return "Product id is invalid";
                              else
                                return null;
                            },
                            controller: model.productIdController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Product id",
                              hintText: "Enter product id",
                            ),
                          );
                        }
                        return Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) {
                                if (val.isEmpty)
                                  return "Category name is invalid";
                                else
                                  return null;
                              },
                              controller: model.categoryNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Category name",
                                hintText: "Enter category name",
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) {
                                if (val.isEmpty)
                                  return "Category id is invalid";
                                else
                                  return null;
                              },
                              controller: model.categoryIdController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Category id",
                                hintText: "Enter category id",
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val.isEmpty)
                          return "Please notification title";
                        else
                          return null;
                      },
                      controller: model.titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Notification title",
                        hintText: "Enter notification title",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val.isEmpty)
                          return "Please message";
                        else
                          return null;
                      },
                      controller: model.messageController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Message",
                        hintText: "Enter message",
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        return null;
                      },
                      controller: model.imageLinkController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Image link(optional)",
                        hintText: "Paste link",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.content_paste),
                          onPressed: () async {
                            final data = await Clipboard.getData('text/plain');
                            model.imageLinkController.text = data.text;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      disabledColor: Colors.grey,
                      padding: const EdgeInsets.all(16),
                      onPressed: model.state == ViewState.Idle
                          ? () async {
                              if (_formKey.currentState.validate()) {
                                await model.sendNotification();
                              }
                            }
                          : null,
                      color: Theme.of(context).accentColor,
                      child: model.state == ViewState.Idle
                          ? Text(
                              "Send notification",
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
                                    "Sending",
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
          ),
        );
      },
    );
  }
}
