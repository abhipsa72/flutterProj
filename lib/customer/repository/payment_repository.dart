import 'package:dio/dio.dart';
import 'package:grand_uae/customer/model/shipping_address.dart';
import 'package:grand_uae/network/dio_network.dart';

class PaymentRepository {
  final DioNetworkUtil _dio;

  PaymentRepository(this._dio);

  Future<Response> setPaymentAddress(ShippingAddress address) => _dio.postForm(
        'index.php?route=custom/payment/address',
        FormData.fromMap({
          'firstname': address.firstName,
          'lastname': address.lastName,
          'address_1': address.address1,
          'address_2': address.address2,
          'city': address.city,
          'country_id': address.countryId,
          'zone_id': address.zoneId,
          'postcode': address.postCode,
        }),
      );

  Future<Response> paymentMethods() =>
      _dio.get('index.php?route=custom/payment/methods');

  Future<Response> setPaymentMethod(String paymentType) => _dio.postForm(
        'index.php?route=custom/payment/method',
        FormData.fromMap({
          'payment_method': paymentType,
        }),
      );
}
