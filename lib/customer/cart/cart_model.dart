import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/cart_item.dart';
import 'package:grand_uae/customer/model/cart_items.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

final doubleRegex = RegExp('(-?[0-9]+(?:[,.][0-9]+)?)', multiLine: true);

class CartModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Repository _repository = locator<Repository>();
  final BuildContext _context;
  final CartProductModel _productModel;
  List<Product> cartProducts = [];
  dynamic minimumOrderTotal;
  List<Total> totalItems = [];
  List<dynamic> vouchersItems = [];
  String errorMessage;

  CartModel(this._context, this._productModel) {
    fetchCartItems();
  }

  bool get isMinimumOrder => minimumOrderTotal != null;

  Future fetchCartItems() async {
    try {
      setState(ViewState.Busy);
      final result = await _repository.fetchCartItems();
      final CartListResponse cartResponse = cartListFromMap(result.data);
      List<Product> products = cartResponse?.success?.products ?? [];
      List<Total> totals = cartResponse.totals;
      List<dynamic> vouchers = cartResponse.vouchers;
      this.minimumOrderTotal = cartResponse.minimumOrderTotal;
      this.cartProducts = products;
      this.totalItems = totals;
      this.vouchersItems = vouchers;
      if (products.isNotEmpty) {
        cartProducts = products;
        updateLocal(products);
      }
      setState(ViewState.Idle);
    } on DioError catch (error) {
      setState(ViewState.Error);
      errorMessage = dioError(error);
      showModel(dioError(error), color: Colors.red);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      showModel(error.toString(), color: Colors.red);
    }
  }

  void updateLocal(List<Product> products) {
    try {
      final localProducts = products.map((product) {
        LocalCartProduct localCartProduct = LocalCartProduct(
          product.productId,
          int.parse(product.quantity),
        );
        return localCartProduct;
      }).toList();
      _productModel.updateProducts(localProducts);
    } on DioError catch (error) {
      setState(ViewState.Error);
      errorMessage = dioError(error);
      showModel(dioError(error), color: Colors.red);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      showModel(error.toString(), color: Colors.red);
    }
  }

  Future updateQuantity(String cartId, String value) async {
    setState(ViewState.Busy);
    try {
      await _repository.updateQuantity(cartId, value);
      setState(ViewState.Idle);
      fetchCartItems();
    } on DioError catch (error) {
      setState(ViewState.Error);
      errorMessage = dioError(error);
      showModel(dioError(error), color: Colors.red);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      showModel(error.toString(), color: Colors.red);
    }
  }

  Future deleteCartItem(Product cartProduct) async {
    setState(ViewState.Busy);
    try {
      await _repository.deleteCartItem(cartProduct.cartId);
      setState(ViewState.Idle);
      _productModel.deleteCartItem(cartProduct.productId);
      Future.delayed(Duration.zero).then((value) {
        fetchCartItems();
      });
    } on DioError catch (error) {
      setState(ViewState.Error);
      errorMessage = dioError(error);
      showModel(dioError(error), color: Colors.red);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      showModel(error.toString(), color: Colors.red);
    }
  }

  void checkoutCart() {
    _navigationService.navigateTo(routes.AddressRoute);
  }

  showDeleteDialog(Product product) {
    showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text("Confirmation"),
          content: Text("Are you sure about delete the ${product.name}"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                deleteCartItem(product);
                Navigator.of(context).pop();
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void showEditDialog(Product product) {
    final _quantityController = TextEditingController(text: product.quantity);
    showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text("Edit ${product.name}"),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: _quantityController,
            decoration: InputDecoration(
              labelText: "Quantity",
              hintText: "Enter quantity",
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                updateQuantity(
                  product.cartId,
                  _quantityController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
