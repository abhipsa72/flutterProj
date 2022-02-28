import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/model/login_country.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:location/location.dart' as LocationPermission;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

const keysPath = "assets/keys/login.json";

class CountrySelectionModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  final Geolocator geoLocator = Geolocator();
  final LocationPermission.Location location = LocationPermission.Location();

  bool _serviceEnabled;
  bool restartButton = false;
  String loadingText = "Initializing";
  Timer _timer;
  LocationPermission.PermissionStatus _permissionGranted;
  String countryName = "N/A";
  Map<String, LoginCountry> _countries = {};

  Map<String, LoginCountry> get countries => _countries;

  CountrySelectionModel() {
    checkLocationEnabled();
    FirebaseMessaging().getToken().then((value) => print(value));
  }

  Future getLocation() async {
    try {
      final data = await location.getLocation();
      geoLocator..forceAndroidLocationManager = true;
      final place = await geoLocator.placemarkFromCoordinates(
        data.latitude, //21.4735,
        data.longitude, //55.9754,
      );
      _countries = await loadCountries();
      final availableCountry = _countries[place[0].country];
      if (availableCountry != null) {
        setAndGo(availableCountry);
      } else {
        countryName = place[0].country;
        notifyListeners();
      }
    } catch (e) {
      loadCountriesWithOutPermission();
    }
  }

  Future<Map<String, LoginCountry>> loadCountries() {
    return rootBundle.loadStructuredData(keysPath, (value) async {
      List<LoginCountry> types = loginCountryFromJson(value);
      Map<String, LoginCountry> loginEntries = {};
      types.forEach((e) => loginEntries[e.name] = e);
      return loginEntries;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future checkLocationEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        loadCountriesWithOutPermission();
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == LocationPermission.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != LocationPermission.PermissionStatus.granted) {
        loadCountriesWithOutPermission();
        return;
      }
    }
    getLocation();
    _timer = Timer(Duration(seconds: 10), () {
      loadingText = "Still loading? try restarting the app!";
      restartButton = true;
      notifyListeners();
    });
  }

  Future loadCountriesWithOutPermission() async {
    _countries = await loadCountries();
    notifyListeners();
  }

  Future setAndGo(LoginCountry country) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(loginKey, country.apiKey);
    prefs.setString(loginUserName, country.userName);
    prefs.setString(selectedCountry, country.name);
    prefs.setString(selectedCountryCode, country.countryCode);

    final countriesToUnSubscribe = _countries.values.where(
      (element) => element.name != country.name,
    );
    countriesToUnSubscribe.map(
      (element) => unSubscribeToTopic(element.name),
    );

    subscribeToTopic("test");
    subscribeToTopic(country.name);
    _navigationService.navigateTo(routes.LoginRoute);
  }

  void unSubscribeToTopic(String topic) {
    FirebaseMessaging().unsubscribeFromTopic(
      "/topics/${topic.toFirebaseTopicName()}",
    );
  }

  void subscribeToTopic(String topic) {
    print("/topics/${topic.toFirebaseTopicName()}");
    FirebaseMessaging().subscribeToTopic(
      "/topics/${topic.toFirebaseTopicName()}",
    );
  }
}
