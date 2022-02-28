import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/banner_response.dart';
import 'package:grand_uae/customer/model/cart_item.dart';
import 'package:grand_uae/customer/model/cart_items.dart';
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/model/category_response.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/model/social_links.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final Repository _repository = locator<Repository>();
  final CartProductModel _productModel;
  List<Banner> _banners = [];
  List<Product> _bestSellingProducts = [];
  List<Product> _popularProducts = [];
  List<Product> _latestProducts = [];
  List<Category> _categoryList = [];
  String errorMessage;
  String _countryName;
  Social _social;

  Social get social => _social;

  set social(Social value) {
    _social = value;
    notifyListeners();
  }

  String get countryName => _countryName;

  set countryName(String value) {
    _countryName = value;
    notifyListeners();
  }

  List<Product> get popularProducts => _popularProducts;

  set popularProducts(List<Product> value) {
    _popularProducts = value;
    notifyListeners();
  }

  List<Product> get latestProducts => _latestProducts;

  set latestProducts(List<Product> value) {
    _latestProducts = value;
    notifyListeners();
  }

  List<Product> get bestSellingProducts => _bestSellingProducts;

  set bestSellingProducts(List<Product> value) {
    _bestSellingProducts = value;
    notifyListeners();
  }

  List<Banner> get banners => _banners;

  set bannerImages(List<Banner> value) {
    _banners = value;
    notifyListeners();
  }

  List<Category> get categories => _categoryList;

  set categories(List<Category> value) {
    _categoryList = value;
    notifyListeners();
  }

  HomeModel(this._productModel) {
    loadHomeDetails(false);
    loadCountryName();
    socialLinks();
  }

  Future loadHomeDetails(bool refresh) async {
    setState(ViewState.Busy);
    try {
      var result = await Future.wait([
        _repository.getBanners(refresh),
        _repository.categories(refresh),
        _repository.getLatestProducts(refresh),
        _repository.getPopularProducts(refresh),
        _repository.getBestSellerProducts(refresh),
        _repository.fetchCartItems()
      ]);
      var banners = bannersFromJson(result[0].data).success?.banners;
      if (banners?.isNotEmpty ?? false) {
        bannerImages = banners;
      }
      var categories = categoryFromHJson(result[1].data).success.categories;
      if (categories.isNotEmpty) {
        this.categories = categories;
      }
      var latestProducts = productFromJson(result[2].data).success.products;
      if (latestProducts.isNotEmpty) {
        this.latestProducts = latestProducts;
      }
      var popularProducts = productFromJson(result[3].data).success.products;
      if (popularProducts.isNotEmpty) {
        this.popularProducts = popularProducts;
      }
      var topSellingProducts = productFromJson(result[4].data).success.products;
      if (topSellingProducts.isNotEmpty) {
        this.bestSellingProducts = topSellingProducts;
      }
      if (cartListFromMap(result[5].data).success?.products?.isNotEmpty ??
          false) {
        var cartItems = cartListFromMap(result[5].data).success.products;
        if (cartItems.isNotEmpty) {
          final localProducts = cartItems.map((product) {
            LocalCartProduct localCartProduct = LocalCartProduct(
              product.productId,
              int.parse(product.quantity),
            );
            return localCartProduct;
          }).toList();
          _productModel.updateProducts(localProducts);
        }
      }
      setState(ViewState.Idle);
    } on DioError catch (error) {
      setState(ViewState.Error);
      errorMessage = dioError(error);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
    }
  }

  void goToProductList(Category category) => _navigationService.navigateTo(
        routes.SubCategoryRoute,
        arguments: category,
      );

  void navigateToSearch() => _navigationService.navigateTo(routes.SearchRoute);

  void navigateTo(String route) => _navigationService.navigateTo(route);

  Future navigateToLogin() async {
    var prefs = await SharedPreferences.getInstance();
    var successful = prefs.getBool(isLoggedIn) ?? false;
    if (successful) {
      navigateTo(routes.ProfileRoute);
    } else {
      var success = await _dialogService.showDialog(
        title: "Alert!",
        description: "Please login to see the profile details",
        buttonTitle: "Login",
        cancelTitle: "Cancel",
        dialogPlatform: DialogPlatform.Material,
      );
      if (success.confirmed) {
        navigateTo(routes.LoginRoute);
      }
    }
  }

  void navigateToSubList(String route, List<Category> arguments) =>
      _navigationService.navigateTo(
        route,
        arguments: arguments,
      );

  Future logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) {
      if (value) {
        _navigationService.navigateTo(routes.CountrySelectionRoute);
      }
    });
  }

  Future loadCountryName() async {
    var prefs = await SharedPreferences.getInstance();
    countryName = prefs.getString(selectedCountry);
  }

  Future navigateToProductCompare() async {
    var prefs = await SharedPreferences.getInstance();
    var productIds = prefs.getStringList(productComparisonList) ?? [];
    if (productIds.isEmpty) {
      _dialogService.showDialog(
        title: "Alert!",
        description: "There are no products to compare.",
        buttonTitle: "OK",
        dialogPlatform: DialogPlatform.Material,
      );
    } else {
      navigateTo(routes.CompareProductsRoute);
    }
  }

  Future socialLinks() async {
    var prefs = await SharedPreferences.getInstance();
    var data = await _repository.socialLinks();
    var links = json.decode(data);
    Social socialLinks = Social.fromMap(
      links[prefs.getString(selectedCountryCode)],
    );
    social = socialLinks;
  }

  void navigateToContactUs(ContactUs contactUs) {
    _navigationService.navigateTo(
      routes.ContactUsRoute,
      arguments: contactUs,
    );
  }

  void navigateToWishlist() {
    _navigationService.navigateTo(
      routes.WishListRoute,
    );
  }

  Future syncCartItems() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(apiToken).isNotEmpty) {
      try {
        var result = await _repository.fetchCartItems();
        var cartItems = cartListFromMap(result.data).success.products;
        if (cartItems.isNotEmpty) {
          final localProducts = cartItems.map((product) {
            LocalCartProduct localCartProduct = LocalCartProduct(
              product.productId,
              int.parse(product.quantity),
            );
            return localCartProduct;
          }).toList();
          _productModel.updateProducts(localProducts);
        }
      } catch (error) {}
    }
  }

  void navigateToAdminLogin() {
    _navigationService.pushNamedAndRemoveUntil(routes.AdminLoginRoute);
  }
}
