import 'package:dio/dio.dart';
import 'package:grand_uae/network/dio_network.dart';

class AddressRepository {
  final DioNetworkUtil _dio;

  AddressRepository(this._dio);

  Future<Response> fetchCountries() =>
      _dio.get("index.php?route=custom/country");

  Future<Response> fetchZones() => _dio.get("index.php?route=custom/zone");
}
