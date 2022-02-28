import 'dart:async';

import 'package:dio/dio.dart';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/model/product_details_response.dart';
import 'package:grand_uae/customer/model/product_review.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailsModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final textController = TextEditingController();
  String errorMessage;
  String _productId;
  Product _product;
  List<Product> _similarProducts;
  List<Review> _reviews;
  var rating = 3.0;
  var _isFavourite = false;

  get isFavourite => _isFavourite;

  set isFavourite(value) {
    _isFavourite = value;
    notifyListeners();
  }

  Product get product => _product;

  set productDetails(Product value) {
    this._product = value;
    notifyListeners();
  }

  List<Review> get reviews => _reviews;

  set reviews(List<Review> value) {
    _reviews = value;
    notifyListeners();
  }

  List<Product> get similarProducts => _similarProducts;

  set similarProducts(List<Product> value) {
    _similarProducts = value;
    notifyListeners();
  }

  ProductDetailsModel(this._productId) {
    fetchProductDetails();
  }

  Future fetchProductDetails() async {
    try {
      setState(ViewState.Busy);
      var result = await Future.wait([
        _repository.productDetails(_productId),
        _repository.similarProducts(_productId),
        _repository.productReviews(_productId)
      ]);
      var product = productDetailsFromMap(result[0].data).success.product;
      productDetails = product;
      isFavourite = product.wishList;
      var similarProducts = productFromJson(result[1].data).success.products;
      if (similarProducts.isNotEmpty) this.similarProducts = similarProducts;

      var reviewResponse = productReviewFromJson(result[2].data);
      this.reviews = reviewResponse.success.reviews;

      setState(ViewState.Idle);
    } on DioError catch (error) {
      FLog.error(text: error.toString());
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future addProductToCart(String productId) async {
    try {
      await _repository.addProductToCart(1, productId);
    } on DioError catch (error) {
      FLog.error(text: error.toString());
    } catch (error) {
      notifyListeners();
    }
  }

  Future addReview() async {
    try {
      setState(ViewState.Busy);
      var prefs = await SharedPreferences.getInstance();
      var result = await _repository.addProductReview(
        _productId,
        textController.text,
        prefs.getString(userName),
        rating,
      );
      setState(ViewState.Idle);
      if (result.data['success'] != null) {
        refreshReviews();
      }
    } on DioError catch (error) {
      FLog.error(text: error.toString());
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error;
      setState(ViewState.Error);
    }
  }

  Future refreshReviews() async {
    setState(ViewState.Busy);
    try {
      var result = await _repository.productReviews(_productId);
      var reviewResponse = productReviewFromJson(result.data).success.reviews;
      if (reviewResponse.isNotEmpty) {
        this.reviews = reviewResponse;
      }
      textController.value = null;
      setState(ViewState.Idle);
    } catch (error) {
      setState(ViewState.Idle);
    }
  }

  Future<bool> addToCompare(String productId) async {
    var prefs = await SharedPreferences.getInstance();
    var productIds = prefs.getStringList(productComparisonList) ?? [];
    if (!productIds.contains(productId)) {
      productIds.add(productId);
      prefs.setStringList(productComparisonList, productIds);
      return true;
    }
    return false;
  }

  void navigateToCompare() {
    navigateTo(routes.CompareProductsRoute);
  }

  Future addToWishlist() async {
    var prefs = await SharedPreferences.getInstance();
    var successful = prefs.getBool(isLoggedIn) ?? false;

    if (successful) {
      try {
        if (isFavourite) {
          isFavourite = false;
          await _repository.removeFromWishlist(_productId);
        } else {
          isFavourite = true;
          await _repository.addToWishlist(_productId);
        }
      } catch (error) {
        print(error);
        //Fluttertoast.showToast(msg: error.toString());
        showModel(error.toString(), color: Colors.red);
      }
    } else {
      var success = await _dialogService.showDialog(
        title: "Alert!",
        description: "Please login to add to wishlist",
        buttonTitle: "Login",
        cancelTitle: "Cancel",
        dialogPlatform: DialogPlatform.Material,
      );
      if (success.confirmed) {
        navigateTo(routes.LoginRoute);
      }
    }
  }

  void navigateTo(String route) => _navigationService.navigateTo(route);
}
