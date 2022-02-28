import 'package:dio/dio.dart';
import 'package:grand_uae/network/dio_network.dart';

class OrderRepository {
  final DioNetworkUtil _dio;

  OrderRepository(this._dio);

  Future<Response> placeOrder() => _dio.get('index.php?route=custom/order/add');

  Future<Response> orderDetails(int orderId) => _dio.get(
        "index.php?route=custom/order/info",
        params: {
          'order_id': orderId,
        },
      );

  Future<Response> orderList() => _dio.get("index.php?route=custom/order");
}
