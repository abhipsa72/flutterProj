import 'package:get_it/get_it.dart';
import 'package:grand_uae/admin/admin_repository.dart';
import 'package:grand_uae/network/dio_network.dart';
import 'package:grand_uae/customer/repository/account_repository.dart';
import 'package:grand_uae/customer/repository/address_repository.dart';
import 'package:grand_uae/customer/repository/cart_repository.dart';
import 'package:grand_uae/customer/repository/checkout_repository.dart';
import 'package:grand_uae/customer/repository/login_repository.dart';
import 'package:grand_uae/customer/repository/order_repository.dart';
import 'package:grand_uae/customer/repository/payment_repository.dart';
import 'package:grand_uae/customer/repository/product_repository.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/customer/repository/shipping_repository.dart';
import 'package:grand_uae/customer/service/basic_details_service.dart';
import 'package:grand_uae/customer/service/push_notification_service.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  final _dio = DioNetworkUtil();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => BasicDetailsService());
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => AddressRepository(_dio));
  locator.registerLazySingleton(() => CartRepository(_dio));
  locator.registerLazySingleton(() => CheckoutRepository(_dio));
  locator.registerLazySingleton(() => LoginRepository(_dio));
  locator.registerLazySingleton(() => OrderRepository(_dio));
  locator.registerLazySingleton(() => PaymentRepository(_dio));
  locator.registerLazySingleton(() => ProductRepository(_dio));
  locator.registerLazySingleton(() => ShippingRepository(_dio));
  locator.registerLazySingleton(() => AccountRepository(_dio));
  locator.registerLazySingleton(() => AdminRepository(_dio));
}
