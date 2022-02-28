import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/customer/country_selection/country_model.dart';
import 'package:grand_uae/customer/model/login_country.dart';
import 'package:grand_uae/customer/model/push_notification_type.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "https://fcm.googleapis.com";
const FIREBASE__AUTH_KEY =
    "AAAAdadj_xc:APA91bHG0hOLCQokA5gJxITanvfuqnJ5MzyTwaclTV8CENylyfJO9b7v-ebPgRDmhMAq02CMszNiYSqBnu6wSLi81b_4Dham34z00DMFzbK8yfhSB2xRkyiZ8XFlM-ihB32PnsijBvsr";

class PushNotificationModel extends BaseViewModel {
  final Dio _dio = Dio();
  final titleController = TextEditingController();
  final productIdController = TextEditingController();
  final categoryIdController = TextEditingController();
  final categoryNameController = TextEditingController();
  final messageController = TextEditingController();
  final imageLinkController = TextEditingController();
  String errorMessage;
  String _topic = '/topics/test';
  LoginCountry _country;
  PushNotificationType _type;
  List<PushNotificationType> _pushNotificationTypes;
  bool _isShowProductInput = true;

  bool get isProductInput => _isShowProductInput;

  set isProductInput(bool value) {
    _isShowProductInput = value;
    notifyListeners();
  }

  LoginCountry get country => _country;

  set country(LoginCountry value) {
    _country = value;
    notifyListeners();
  }

  PushNotificationType get type => _type;

  set type(PushNotificationType value) {
    _type = value;
    notifyListeners();
  }

  List<PushNotificationType> get pushNotificationTypes =>
      _pushNotificationTypes;

  set pushNotificationTypes(List<PushNotificationType> value) {
    _pushNotificationTypes = value;
    notifyListeners();
  }

  Map<String, LoginCountry> _countries = {};

  Map<String, LoginCountry> get countries => _countries;

  PushNotificationModel() {
    //_topic = '/topics/test';
    //"/topics/${_basicDetails.countryName.toFirebaseTopicName()}";
    loadCountriesList();
    loadPushNotificationTypes();
  }

  loadPushNotificationTypes() {
    final List<PushNotificationType> list = [];
    list.add(PushNotificationType(
      name: 'Product',
      type: 'product_id',
    ));
    list.add(PushNotificationType(
      name: 'Category',
      type: 'category_id',
    ));
    pushNotificationTypes = list;
  }

  Future loadCountriesList() async {
    _countries = await loadCountries();
    var prefs = await SharedPreferences.getInstance();

    country = _countries.values.firstWhere(
      (element) => element.countryName == prefs.getString(selectedCountry),
      orElse: null,
    );
    notifyListeners();
  }

  Future<Map<String, LoginCountry>> loadCountries() {
    return rootBundle.loadStructuredData(keysPath, (value) async {
      List<LoginCountry> types = loginCountryFromJson(value);
      Map<String, LoginCountry> loginEntries = {};
      types.forEach((e) => loginEntries[e.name] = e);
      return loginEntries;
    });
  }

  sendNotification() {
    String title = titleController.text;
    String message = messageController.text;
    String imageLink = imageLinkController.text;
    String productId = productIdController.text;
    String categoryName = categoryNameController.text;
    String categoryId = categoryIdController.text;
    try {
      setState(ViewState.Busy);
      final notificationType =
          isProductInput ? 'product_details' : 'product_list';
      //_topic = "/topics/${_basicDetails.countryName.toFirebaseTopicName()}";
      _dio.options.headers['Authorization'] = 'key=$FIREBASE__AUTH_KEY';
      _dio.options.headers['Content-Type'] = 'application/json';
      var url = 'https://fcm.googleapis.com/fcm/send';
      var jsonData = jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': message,
            'title': title,
            "image": imageLink ?? null,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'product_id': productId,
            'category_id': categoryId,
            'notification_type': notificationType,
            'category_name': categoryName,
          },
          'to': _topic,
        },
      );
      _dio.post(url, data: jsonData).then((value) {
        print("Response: $value");
        categoryIdController.clear();
        categoryNameController.clear();
        productIdController.clear();
        imageLinkController.clear();
        messageController.clear();
        titleController.clear();
        setState(ViewState.Idle);
        showModel(
          "Notification sent successfully!",
          color: Colors.red,
        );
      }).catchError((error) {
        showModel(
          "Something went wrong while sending notification.",
          color: Colors.red,
        );
      });
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
    }
  }

  @override
  void dispose() {
    categoryIdController.dispose();
    categoryNameController.dispose();
    productIdController.dispose();
    imageLinkController.dispose();
    messageController.dispose();
    titleController.dispose();
    super.dispose();
  }
}
