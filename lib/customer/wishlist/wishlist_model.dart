import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class WishListModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  List<Product> _products;
  String errorMessage;

  List<Product> get products => _products;

  WishListModel() {
    wishListProducts();
  }

  set products(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  Future<void> addOrDelete(String productId) async {
    var result = await _repository.addOrDelete(productId, true);
    showModel(result.data['success']['message']);
  }

  Future wishListProducts() async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.wishListProducts();
      var productsResponse = productFromJson(result.data);
      this.products = productsResponse.success.products;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Idle);
      showModel(
        "Something is wrong, please try",
        color: Colors.red,
      );
    }
  }
}
