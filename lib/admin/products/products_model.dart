import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/admin/enums/sort_with_product.dart';
import 'package:grand_uae/admin/model/attributes_response.dart';
import 'package:grand_uae/admin/model/filter_products.dart';
import 'package:grand_uae/admin/model/order_status_response.dart';
import 'package:grand_uae/admin/model/products_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class ProductsModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  SortWithProduct _sortWithProduct = SortWithProduct.Default;
  List<Status> _orderStatuses = [];
  int _selectStatus;

  SortWithProduct get sortWithProduct => _sortWithProduct;

  set sortWithProduct(SortWithProduct value) {
    _sortWithProduct = value;
    notifyListeners();
  }

  int get selectStatus => _selectStatus;

  set selectStatus(int value) {
    _selectStatus = value;
    notifyListeners();
  }

  List<Status> get orderStatuses => _orderStatuses;

  set orderStatuses(List<Status> value) {
    _orderStatuses = value;
    notifyListeners();
  }

  PagewiseLoadController pageLoadController = PagewiseLoadController(
    pageFuture: (int pageIndex) {
      return Future.value();
    },
    pageSize: 30,
  );

  ProductsModel() {
    fetchOrderStatus();
    pageLoadController = PagewiseLoadController(
      pageFuture: (pageIndex) => fetchProducts(
        pageIndex + 1,
      ),
      pageSize: 30,
    );
  }

  Future fetchOrderStatus() async {
    try {
      setState(ViewState.Busy);
      var results = await _repository.orderStatus();
      this.orderStatuses = orderStatusFromMap(results.data).success.orders;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      setState(ViewState.Error);
    } catch (error) {
      setState(ViewState.Error);
    }
  }

  Future<List<AdminProduct>> fetchProducts(int page) async {
    String quantity = quantityController.text;
    String price = priceController.text;
    String name = nameController.text;
    String model = modelController.text;
    String sort = sortMap.reverse[_sortWithProduct];

    var results = await _repository.adminProducts(
      FilterProducts(
        status: _selectStatus,
        quantity: quantity ?? null,
        price: price ?? null,
        name: name ?? null,
        model: model ?? null,
        start: page,
        limit: 30,
      ),
      sort,
    );
    return adminProductsFromMap(results.data).success.products;
  }

  void filterProducts() {
    pageLoadController.reset();
  }

  void clearDetails() {
    quantityController.clear();
    priceController.clear();
    nameController.clear();
    modelController.clear();
    pageLoadController.reset();
  }
}

var sortMap = EnumValues<SortWithProduct>({
  'pd.name&order=ASC': SortWithProduct.ProductName,
  'pd.name&order=DESC': SortWithProduct.ProductNameDesc,
  'p.model&order=ASC': SortWithProduct.Model,
  'p.model&order=DESC': SortWithProduct.ModelDesc,
  'p.price&order=ASC': SortWithProduct.Price,
  'p.price&order=DESC': SortWithProduct.PriceDesc,
  'p.quantity&order=ASC': SortWithProduct.Quantity,
  'p.quantity&order=DESC': SortWithProduct.QuantityDesc,
  'p.status&order=ASC': SortWithProduct.Status,
  'p.status&order=DESC': SortWithProduct.StatusDesc,
});
