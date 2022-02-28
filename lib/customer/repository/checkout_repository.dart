import 'package:dio/dio.dart';
import 'package:grand_uae/customer/model/profile.dart';
import 'package:grand_uae/network/dio_network.dart';

class CheckoutRepository {
  final DioNetworkUtil _dio;

  CheckoutRepository(this._dio);

  Future<Response> setUserDetailsForOrder(Profile profile) => _dio.postForm(
        "index.php?route=api/customer",
        FormData.fromMap({
          'firstname': profile.firstName,
          'lastname': profile.lastName,
          'email': profile.email,
          'telephone': profile.phone
        }),
      );
}
