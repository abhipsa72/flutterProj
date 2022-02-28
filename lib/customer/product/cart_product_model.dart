import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/cart_item.dart';
import 'package:grand_uae/customer/model/clear_cart_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class CartProductModel extends ValueNotifier<List<LocalCartProduct>> {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  bool isLoading = false;
  int totalPrice = 0;

  CartProductModel(List<LocalCartProduct> value) : super(value);

  void addCartProducts(LocalCartProduct localProduct) {
    var hasItem = value.singleWhere(
      (product) => product.productId == localProduct.productId,
      orElse: () {
        return null;
      },
    );
    if (hasItem != null) {
      if (localProduct.quantity == 0) {
        value.removeWhere(
            (product) => product.productId == localProduct.productId);
      } else {
        var product = value.firstWhere(
            (product) => product.productId == localProduct.productId);
        product.quantity = localProduct.quantity;
      }
    } else {
      bool isEmpty = value
          .where((iterator) => iterator.productId == localProduct.productId)
          .isEmpty;
      if (isEmpty) {
        value.add(localProduct);
      }
    }
    notifyListeners();
  }

  Future clearCart() async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await _repository.clearCart();
      ClearCartResponse response = clearCartFromJson(result.data);
      bool isResponseTrue = response.success.message.isEmpty;
      if (isResponseTrue) {
        showModel("Something went wrong");
      } else {
        addItemsToCart();
      }
    } on DioError catch (error) {
      showModel(dioError(error), color: Colors.red);
      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
      showModel(dioError(error), color: Colors.red);
    }
  }

  Future addItemsToCart() async {
    try {
      final requests = value.map((iterator) => _repository.addProductToCart(
            iterator.quantity,
            iterator.productId,
          ));
      final result = await Future.wait(requests);
      isLoading = false;
      final doesContainError = result
          .map((Response response) => response.data['success'] == null)
          .where((iterator) => iterator != true);

      if (doesContainError.isEmpty) {
        //Fluttertoast.showToast(msg: "Show error dialog");
        //showSessionErrorDialog(_context, showRetry: true);
      } else {
        _navigationService.navigateTo(routes.CartDetailsRoute);
      }
      notifyListeners();
    } on DioError catch (error) {
      showModel(dioError(error), color: Colors.red);
      isLoading = false;
      notifyListeners();
    } catch (error) {
      showModel(error.toString(), color: Colors.red);
    }
  }

  void deleteCartItem(String productId) {
    value.removeWhere((e) => e.productId == productId);
    notifyListeners();
  }

  void updateProducts(List<LocalCartProduct> products) {
    value = products;
    notifyListeners();
  }

  Future<bool> checkLoginOrNot() async {
    final prefs = await SharedPreferences.getInstance();
    var userLogged = prefs.getBool(isLoggedIn) ?? false;
    if (!userLogged) {
      _navigationService.navigateTo(routes.LoginRoute);
      return false;
    }
    return true;
  }
}
