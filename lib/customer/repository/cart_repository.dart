import 'package:dio/dio.dart';
import 'package:grand_uae/network/dio_network.dart';

class CartRepository {
  final DioNetworkUtil _dio;

  CartRepository(this._dio);

  Future<Response> fetchCartItems() => _dio.get("index.php?route=custom/cart");

  Future<Response> updateQuantity(String cartId, String value) => _dio.postForm(
        "index.php?route=custom/cart/edit",
        FormData.fromMap({
          "cart_id": cartId,
          "quantity": value,
        }),
      );

  Future<Response> deleteCartItem(String cartId) => _dio.delete(
        "index.php?route=custom/cart/remove",
        params: {
          "cart_id": cartId,
        },
      );

  //https://www.grandhypermarkets.com/uae/index.php?route=api/allproducts/clearCart&sessionId=24ddd23fe8860eb55c8da71caa
  Future<Response> clearCart() async {
    return _dio.delete("index.php?route=custom/cart/clear");
  }
}
