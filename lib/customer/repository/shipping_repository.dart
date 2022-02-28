import 'package:dio/dio.dart';
import 'package:grand_uae/customer/model/shipping_address.dart';
import 'package:grand_uae/network/dio_network.dart';

class ShippingRepository {
  final DioNetworkUtil _dio;

  ShippingRepository(this._dio);

  Future<Response> setShippingAddress(ShippingAddress address) => _dio.postForm(
        'index.php?route=custom/shipping/address',
        FormData.fromMap({
          'firstname': address.firstName,
          'lastname': address.lastName,
          'address_1': address.address1,
          'address_2': address.address2,
          'city': address.city,
          'country_id': address.countryId,
          'zone_id': address.zoneId,
          'postcode': address.postCode,
          'default': address.isDefault ?? false ? 1 : 0,
        }),
      );

  Future<Response> shippingMethods() =>
      _dio.get('index.php?route=custom/shipping/methods');

  Future<Response> timeSlots() => _dio.get('index.php?route=custom/timeslot');

  Future<Response> setShippingMethod(String method) => _dio.postForm(
        'index.php?route=custom/shipping/method',
        FormData.fromMap({
          'shipping_method': method,
        }),
      );

  Future<Response> setTimeSlot(String dateTime, String time) => _dio.get(
        "index.php?route=custom/order/add",
        params: {
          'eb_delivery_date': dateTime,
          'eb_delivery_time': time,
        },
      );
}
