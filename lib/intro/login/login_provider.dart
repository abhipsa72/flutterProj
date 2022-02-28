import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:zel_app/IT/it_product_page.dart';
import 'package:zel_app/common/loading.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/finance/finance_home_page.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/marketing_engine/existing_campaign/existing_campaign.dart';
import 'package:zel_app/marketing_engine/marketing_engine.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/purchaser/home/purchaser_home_page.dart';
import 'package:zel_app/rca/Region/RCA.dart';
import 'package:zel_app/stock_out/stockout.dart';
import 'package:zel_app/store_manager/store_manager.dart';
import 'package:zel_app/util/dio_network.dart';
import 'package:zel_app/util/enum_values.dart';
import 'package:zel_app/views/NoInternet.dart';
import 'package:zel_app/warehouse_manager/product/warehouse_manager_page.dart';

class LoginProvider extends Loading {
  final DataManagerRepository _dataManagerRepository;

  LoginProvider(this._dataManagerRepository);

  loginUser(BuildContext context, String email, String password) async {
    setLoading(true);
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final result = await _dataManagerRepository.login(email, password);
        LoginResponse loginResponse = LoginResponse.fromMap(result.data);
        print(rolesMap.maps[loginResponse.user.roles]);
        setLoading(false);
        Hive.openBox(userDetailsBox).then(
          (value) {
            value.put(authTokenBoxKey, loginResponse.user.authToken);
            value.put(companyIdBoxKey, loginResponse.user.companyId);
            value.put(userNameBoxKey, loginResponse.user.name);
            value.put(userEmailBoxKey, email);
            value.put(userPasswordBoxKey, password);
            value.put(userStoreKey, loginResponse.user.storeName);
            value.put(userContactNoKey, loginResponse.user.contactNumber);
            value.put(
                userRoleBoxKey, rolesMap.reverse[loginResponse.user.roles]);

            if (loginResponse.user.roles == Roles.ROLE_STORE_MANAGER) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  StoreManagerPage.routeName, (route) => false);
            } else if (loginResponse.user.roles ==
                Roles.ROLE_WAREHOUSE_MANAGER) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  WarehouseHomePage.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.ROLE_PURCHASER) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  PurchaserPage.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.ROLE_FINANCE) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  FinancePage.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.ROLE_AGENT) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  ExistingCampaign.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.ROLE_MD) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  ManagingDirectorPage.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.ROLE_ANALYTICS) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  MarketEngine.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.ROLE_IT) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  ItProductPage.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.ROLE_RCA) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RCA.routeName, (route) => false);
            } else if (loginResponse.user.roles == Roles.Stock_manager) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  StackOut.routeName, (route) => false);
            } else if (loginResponse.user.authToken == null) {
              showAlert(context);
            } else if (value == ConnectivityStatus.Offline) {
              return NoInternet();
            } else {
              print("Something else");
            }
          },
        );
        if (loginResponse.user == null) {
          Fluttertoast.showToast(
              msg: "User not available !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } on DioError catch (error) {
        print("Error: $error");
        Fluttertoast.showToast(
            msg: handleError(error),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);

        setLoading(false);
      }
    }
  }
}

showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Text(
          "Could not found user !",
          style: TextStyle(color: Colors.redAccent),
        ),
      );
    },
  );
}
