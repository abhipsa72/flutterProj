import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/currency_code.dart';
import 'package:grand_uae/customer/model/language_code.dart';
import 'package:grand_uae/customer/model/login_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashModel extends BaseViewModel {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  final NavigationService _navigationService = locator<NavigationService>();
  final Repository _repository = locator<Repository>();
  String message = "";

  SplashModel() {
    fetchDetails();
  }

  Future fetchDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(apiToken) ?? "";
    useCountryCode = prefs.getString(selectedCountryCode);
    setState(ViewState.Busy);
    if (token.isNotEmpty) {
      try {
        final resultList = await Future.wait([
          _repository.getCurrencyCode(),
          _repository.getLanguageCode(),
        ]);
        Currency currency =
            currencyListFromMap(resultList[0].data)?.success?.currencies?.first;
        Language language =
            languageListFromMap(resultList[1].data)?.success?.languages?.first;

        await _repository.setSessionCode(
          language.languageId,
          currency.currencyId,
        );
        setState(ViewState.Idle);
        setUserId();
      } on DioError catch (error) {
        print("Dio error");
        if (error.response != null && error.response.statusCode == 401) {
          setState(ViewState.Busy);
          try {
            var result = await _repository.refreshToken();
            LoginResponse user = userFromJson(result.data);
            prefs.setString(
              apiToken,
              user.success.apiToken,
            );
            fetchDetails();
            setState(ViewState.Idle);
          } on DioError catch (error) {
            setState(ViewState.Error);
            message = dioError(error);
            //FLog.error(text: dioError(error));
          } catch (error) {
            setState(ViewState.Error);
            //FLog.error(text: error.toString());
          }
          print("error");
        } else {
          print("Else error");
          message = dioError(error);
          //FLog.error(text: error.toString());
          setState(ViewState.Error);
        }
      } catch (error) {
        print("error error");
        message = "Something went wrong, please try again!";
        //FLog.error(text: error.toString());
        setState(ViewState.Error);
      }
    } else {
      setUserId();
    }
  }

  void setUserId() {
    FirebaseMessaging().getToken().then((value) {
      print(value);
      _analytics.setUserId(value);
      Timer(Duration(seconds: 2), () {
        setState(ViewState.Idle);
        _navigationService.pushNamedAndRemoveUntil(routes.HomePageRoute);
      });
    });
  }

  Future clearAndGoBack() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear().then((bool value) {
      if (value) {
        _navigationService.navigateTo(routes.CountrySelectionRoute);
      }
    });
  }
}
