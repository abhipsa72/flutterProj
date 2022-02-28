import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/IT/it_product_page.dart';
import 'package:zel_app/IT/it_provider.dart';
import 'package:zel_app/finance/finance_home_page.dart';
import 'package:zel_app/finance/finance_page_provider.dart';
import 'package:zel_app/intro/forgot_password/change_password.dart';
import 'package:zel_app/intro/forgot_password/forgot_password_page.dart';
import 'package:zel_app/intro/forgot_password/password_proider.dart';
import 'package:zel_app/intro/language_selection/language_selection_provider.dart';
import 'package:zel_app/intro/login/login_page.dart';
import 'package:zel_app/intro/register/register_page.dart';
import 'package:zel_app/intro/register/register_provider.dart';
import 'package:zel_app/intro/splash_screen_page.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/marketing_engine/existing_campaign/existing_campaign.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/marketing_engine/marketing_engine.dart';
import 'package:zel_app/purchaser/home/purchaser_home_page.dart';
import 'package:zel_app/purchaser/purchaser_page_provider.dart';
import 'package:zel_app/rca/Region/RCA.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/stock_out/stock_out_provider.dart';
import 'package:zel_app/stock_out/stockout.dart';
import 'package:zel_app/store_manager/home_page_provider.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';
import 'package:zel_app/store_manager/store_manager.dart';
import 'package:zel_app/util/connectivity.dart';
import 'package:zel_app/warehouse_manager/product/warehouse_manager_page.dart';
import 'package:zel_app/warehouse_manager/warehouse_manager_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final _repository = DataManagerRepository();
  // final FirebaseMessaging _messaging = FirebaseMessaging();
//  final PushNotificationService _service = PushNotificationService();
  runApp(
    MultiProvider(
      providers: [
        Provider<DataManagerRepository>(
          create: (context) => _repository,
        ),
        StreamProvider(
          create: (_) => ConnectivityService().connectionStream,
        ),
        ChangeNotifierProvider<FinanceProviderBloc>(
          create: (context) => FinanceProviderBloc(_repository),
        ),
        ChangeNotifierProvider<PurchaserProvider>(
          create: (context) => PurchaserProvider(_repository),
        ),
        ChangeNotifierProvider<WarehouseManagerProvider>(
          create: (context) => WarehouseManagerProvider(_repository),
        ),
        ChangeNotifierProvider<ProductListingProvider>(
          create: (context) => ProductListingProvider(_repository),
        ),
        ChangeNotifierProvider<ChartsProvider>(
          create: (context) => ChartsProvider(_repository),
        ),
        ChangeNotifierProvider<PasswordChangeProvider>(
          create: (context) => PasswordChangeProvider(_repository),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (context) => RegisterProvider(_repository),
        ),
        ChangeNotifierProvider<LanguageSelectionProvider>(
          create: (context) => LanguageSelectionProvider(_repository),
        ),
        ChangeNotifierProvider<MarketingEngineProvider>(
          create: (context) => MarketingEngineProvider(_repository),
        ),
        ChangeNotifierProvider<ManagingDirectorProvider>(
          create: (context) => ManagingDirectorProvider(_repository),
        ),
        ChangeNotifierProvider<ItProvider>(
          create: (context) => ItProvider(_repository),
        ),
        ChangeNotifierProvider<RCAProvider>(
          create: (context) => RCAProvider(_repository),
        ),
        ChangeNotifierProvider<StockOutProvider>(
          create: (context) => StockOutProvider(_repository),
        ),
      ],
      child: ZelApp(),
    ),
  );
}

class ZelApp extends StatefulWidget {
  @override
  _ZelAppState createState() => _ZelAppState();
}

class _ZelAppState extends State<ZelApp> {
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//  _register() {
//    _firebaseMessaging.getToken().then((token) =>x());
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    setState(() {
//      getMessage();
//    });
//     getMessage();
//     _firebaseMessaging.getToken().then((token) => print(token));
  }

  // void getMessage() {
  //   _firebaseMessaging.configure(
  //       onMessage: (Map<String, dynamic> message) async {
  //     print('on message $message');
  //     // setState(() => _message = message["notification"]["title"]);
  //   }, onResume: (Map<String, dynamic> message) async {
  //     print('on resume $message');
  //     //setState(() => _message = message["notification"]["title"]);
  //   }, onLaunch: (Map<String, dynamic> message) async {
  //     print('on launch $message');
  //     // setState(() => _message = message["notification"]["title"]);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          accentColor: Colors.deepOrangeAccent,
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          primaryColor: Colors.deepOrangeAccent),
      theme: ThemeData(
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        accentColor: Colors.deepOrangeAccent,
        primaryColor: Colors.deepOrange,
      ),
      // actions: _register(),

      routes: {
        SplashScreenPage.routeName: (context) => SplashScreenPage(),
        // LanguageSelectionPage.routeName: (context) => LanguageSelectionPage(),
        StoreManagerPage.routeName: (context) => StoreManagerPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        LoginPage.routeName: (context) => LoginPage(),
        ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
        ChangePasswordPage.routeName: (context) => ChangePasswordPage(),
        WarehouseHomePage.routeName: (context) => WarehouseHomePage(),
        PurchaserPage.routeName: (context) => PurchaserPage(),
        FinancePage.routeName: (context) => FinancePage(),
        MarketEngine.routeName: (context) => MarketEngine(),
        ExistingCampaign.routeName: (context) => ExistingCampaign(),
        ManagingDirectorPage.routeName: (context) => ManagingDirectorPage(),
        ItProductPage.routeName: (context) => ItProductPage(),
        RCA.routeName: (context) => RCA(),
        StackOut.routeName: (context) => StackOut()
      },
    );
  }
}
