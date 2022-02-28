import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/IT/it_product_page.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/finance/finance_home_page.dart';
import 'package:zel_app/intro/login/login_page.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/marketing_engine/existing_campaign/existing_campaign.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/purchaser/home/purchaser_home_page.dart';
import 'package:zel_app/rca/Region/RCA.dart';
import 'package:zel_app/stock_out/stockout.dart';
import 'package:zel_app/store_manager/store_manager.dart';
import 'package:zel_app/util/enum_values.dart';
import 'package:zel_app/views/NoInternet.dart';
import 'package:zel_app/warehouse_manager/product/warehouse_manager_page.dart';

class SplashScreenPage extends StatefulWidget {
  static var routeName = "/";

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future delayLaunch() {
    return Future.delayed(
      Duration(
        seconds: 3,
      ),
    ).then(
      (value) => {
        Hive.openBox(userDetailsBox).then(
          (value) {
            if (value.get(authTokenBoxKey) == null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            } else {
              final role = rolesMap.maps[value.get(userRoleBoxKey)];
              // print(role);
              switch (role) {
                case Roles.ROLE_STORE_MANAGER:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      StoreManagerPage.routeName, (route) => false);
                  break;
                case Roles.ROLE_WAREHOUSE_MANAGER:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      WarehouseHomePage.routeName, (route) => false);
                  break;
                case Roles.ROLE_PURCHASER:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      PurchaserPage.routeName, (route) => false);
                  break;
                case Roles.ROLE_FINANCE:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      FinancePage.routeName, (route) => false);
                  break;
                case Roles.ROLE_ANALYTICS:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ExistingCampaign.routeName, (route) => false);
                  break;
                case Roles.ROLE_MD:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ManagingDirectorPage.routeName, (route) => false);
                  break;
                case Roles.ROLE_IT:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ItProductPage.routeName, (route) => false);
                  break;
                case Roles.ROLE_RCA:
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(RCA.routeName, (route) => false);
                  break;
                case Roles.Stock_manager:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      StackOut.routeName, (route) => false);
                  break;
                default:
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                  break;
              }
            }
          },
        )
      },
    );
  }

  @override
  void initState() {
    delayLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityStatus>(builder: (_, value, child) {
      if (value == ConnectivityStatus.Offline) {
        print(value);
        print("abc");
        return NoInternet();
      }
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.orange,
                Colors.deepOrange,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/zedeye_logo.png",
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
