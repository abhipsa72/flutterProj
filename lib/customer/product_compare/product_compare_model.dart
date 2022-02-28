import 'package:dio/dio.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/model/product_compare_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductCompareModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  List<Product> _products = [];
  String errorMessage;

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  ProductCompareModel() {
    fetchProductComparison();
  }

  Future fetchProductComparison() async {
    setState(ViewState.Busy);
    try {
      var result = await _repository.productComparison();
      ProductCompareResponse compare = compareFromJson(result.data);
      products = compare.success.products;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      products = [];
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      products = [];
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  void navigateToProduct(Product product) {
    _navigationService.navigateTo(
      routes.ProductDetailsRoute,
      arguments: product.productId,
    );
  }

  Future deleteProduct(String productId) async {
    var prefs = await SharedPreferences.getInstance();
    var productIds = prefs.getStringList(productComparisonList) ?? [];
    if (productIds.contains(productId)) {
      productIds.remove(productId);
      prefs.setStringList(productComparisonList, productIds);
      fetchProductComparison();
      showModel("Product removed");
    }
  }
}
