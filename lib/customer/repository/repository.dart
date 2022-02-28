import 'package:dio/dio.dart';
import 'package:grand_uae/admin/admin_repository.dart';
import 'package:grand_uae/admin/model/add_category.dart';
import 'package:grand_uae/admin/model/add_customer.dart';
import 'package:grand_uae/admin/model/filter_products.dart';
import 'package:grand_uae/admin/orders/filter_orders.dart';
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/model/profile.dart';
import 'package:grand_uae/customer/model/shipping_address.dart';
import 'package:grand_uae/customer/repository/account_repository.dart';
import 'package:grand_uae/customer/repository/address_repository.dart';
import 'package:grand_uae/customer/repository/cart_repository.dart';
import 'package:grand_uae/customer/repository/checkout_repository.dart';
import 'package:grand_uae/customer/repository/login_repository.dart';
import 'package:grand_uae/customer/repository/order_repository.dart';
import 'package:grand_uae/customer/repository/payment_repository.dart';
import 'package:grand_uae/customer/repository/product_repository.dart';
import 'package:grand_uae/customer/repository/shipping_repository.dart';
import 'package:grand_uae/locator.dart';

class Repository {
  final AdminRepository _adminRepository = locator<AdminRepository>();
  final AddressRepository _addressRepository = locator<AddressRepository>();
  final CartRepository _cartRepository = locator<CartRepository>();
  final CheckoutRepository _checkoutRepository = locator<CheckoutRepository>();
  final LoginRepository _loginRepository = locator<LoginRepository>();
  final OrderRepository _orderRepository = locator<OrderRepository>();
  final PaymentRepository _paymentRepository = locator<PaymentRepository>();
  final ProductRepository _productRepository = locator<ProductRepository>();
  final ShippingRepository _shippingRepository = locator<ShippingRepository>();
  final AccountRepository _accountRepository = locator<AccountRepository>();

  Future<Response> setUserDetailsForOrder(Profile profile) =>
      _checkoutRepository.setUserDetailsForOrder(profile);

  Future<Response> setShippingAddress(ShippingAddress address) =>
      _shippingRepository.setShippingAddress(address);

  Future<Response> shippingMethods() => _shippingRepository.shippingMethods();

  Future<Response> timeSlots() => _shippingRepository.timeSlots();

  Future<Response> setShippingMethod(String method) =>
      _shippingRepository.setShippingMethod(method);

  Future<Response> categories(bool forceRefresh) =>
      _productRepository.categories(forceRefresh);

  Future<Response> subCategories(categoryId, bool forceRefresh) =>
      _productRepository.subCategories(categoryId, forceRefresh);

  Future<Response> productsByCategory(String categoryCode) =>
      _productRepository.productsByCategory(categoryCode);

  Future<Response> productsByCategoryWithPage(
    String categoryId,
    String subCategoryId,
    page,
  ) =>
      _productRepository.productsByCategoryWithPage(
        categoryId,
        subCategoryId,
        page,
      );

  Future<Response> productDetails(String productId) =>
      _productRepository.productDetails(productId);

  Future<Response> addProductReview(
    String productId,
    String review,
    String author,
    double rating,
  ) =>
      _productRepository.addProductReview(
        productId,
        review,
        rating,
        author,
      );

  Future<Response> similarProducts(String productId) =>
      _productRepository.similarProducts(productId);

  Future<Response> productReviews(String productId) =>
      _productRepository.productReviews(productId);

  Future<Response> addProductToCart(int quantity, String productId) =>
      _productRepository.addProductToCart(quantity, productId);

  Future<Response> setPaymentAddress(ShippingAddress address) =>
      _paymentRepository.setPaymentAddress(address);

  Future<Response> paymentMethods() => _paymentRepository.paymentMethods();

  Future<Response> setPaymentMethod(String paymentType) =>
      _paymentRepository.setPaymentMethod(paymentType);

  Future<Response> placeOrder() => _orderRepository.placeOrder();

  Future<Response> orderDetails(int orderId) =>
      _orderRepository.orderDetails(orderId);

  Future<Response> fetchCountries() => _addressRepository.fetchCountries();

  Future<Response> fetchZones() => _addressRepository.fetchZones();

  Future<Response> fetchCartItems() => _cartRepository.fetchCartItems();

  Future<Response> updateQuantity(String cartId, String value) =>
      _cartRepository.updateQuantity(cartId, value);

  Future<Response> deleteCartItem(String cartId) =>
      _cartRepository.deleteCartItem(cartId);

  Future<Response> sessionLogin() => _loginRepository.sessionLogin();

  Future<Response> loginUserNamePassword(String email, String password) =>
      _loginRepository.loginUserNamePassword(email, password);

  Future<Response> getBanners(bool refresh) =>
      _productRepository.getBanners(refresh);

  Future<Response> getBestSellerProducts(bool refresh) =>
      _productRepository.getBestSellerProducts(refresh);

  Future<Response> getPopularProducts(bool refresh) =>
      _productRepository.getPopularProducts(refresh);

  Future<Response> getLatestProducts(bool refresh) =>
      _productRepository.getLatestProducts(refresh);

  Future<Response> search(
    String searchQuery,
    String sortWithOrder,
    String categoryId,
    String subCategoryId,
  ) =>
      _productRepository.search(
        searchQuery,
        sortWithOrder,
        categoryId,
        subCategoryId,
      );

  Future<Response> getCurrencyCode() => _loginRepository.getCurrencyCode();

  Future<Response> getCountryCode() => _loginRepository.getCountryCode();

  Future<Response> getLanguageCode() => _loginRepository.getLanguageCode();

  Future<Response> setSessionCode(String languageId, String currencyId) =>
      _loginRepository.setSessionCode(languageId, currencyId);

  Future<Response> clearCart() => _cartRepository.clearCart();

  Future<Response> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String confirmPassword,
    bool isAgree,
    bool isNewsLetter,
  ) =>
      _loginRepository.register(
        firstName,
        lastName,
        email,
        phone,
        password,
        confirmPassword,
        isAgree,
        isNewsLetter,
      );

  Future<Response> addOrDelete(String productId, bool isAdding) => isAdding
      ? _productRepository.add(productId)
      : _productRepository.delete(productId);

  Future<Response> wishListProducts() => _productRepository.wishListProducts();

  Future<Response> productComparison() =>
      _productRepository.productComparison();

  Future<String> socialLinks() => _productRepository.socialLinks();

  Future<Response> orderList() => _orderRepository.orderList();

  Future<Response> fetchAccountDetails() =>
      _accountRepository.fetchAccountDetails();

  Future<Response> deleteAddress(String addressId) =>
      _accountRepository.deleteAccount(addressId);

  Future<Response> addAddressBook(AddressBook sendAddressBook) =>
      _accountRepository.addAddressBook(sendAddressBook);

  Future<Response> updateAddressBook(AddressBook sendAddressBook) =>
      _accountRepository.updateAddressBook(sendAddressBook);

  Future<Response> updateUserDetails(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
  ) =>
      _accountRepository.updateUserDetails(
        firstName,
        lastName,
        email,
        phoneNumber,
      );

  Future<Response> updatePassword(
    String password,
    String confirmPassword,
  ) =>
      _accountRepository.updatePassword(
        password,
        confirmPassword,
      );

  Future<Response> forgotPasswordMail(String email) =>
      _loginRepository.forgotPasswordMail(email);

  Future<Response> refreshToken() => _loginRepository.refresh();

  Future<Response> categoryDetails(String categoryId) =>
      _productRepository.categoryDetails(categoryId);

  Future<Response> setTimeSlot(String dateTime, String time) =>
      _shippingRepository.setTimeSlot(dateTime, time);

  Future<Response> addToWishlist(String productId) =>
      _productRepository.addToWishlist(productId);

  Future<Response> removeFromWishlist(String productId) =>
      _productRepository.removeFromWishlist(productId);

  /*
  * Admin APIs
  * */
  Future<Response> adminLogin(String username, String password) =>
      _adminRepository.login(username, password);

  Future<Response> adminCategories() => _adminRepository.categories();

  Future<Response> fetchManufactures() => _adminRepository.fetchManufactures();

  Future<Response> fetchAttributes() => _adminRepository.fetchAttributes();

  Future<Response> fetchAttribute(String attributeId) =>
      _adminRepository.fetchAttribute(attributeId);

  Future<Response> deleteAttribute(String attributeId) =>
      _adminRepository.deleteAttribute(attributeId);

  Future<Response> addCategory(AddCategory category) =>
      _adminRepository.addCategory(category);

  Future<Response> editCategory(AddCategory category) =>
      _adminRepository.editCategory(category);

  Future<Response> deleteCategory(String categoryId) =>
      _adminRepository.deleteCategory(categoryId);

  Future<Response> customers(
    int page,
    String name,
    String email,
  ) =>
      _adminRepository.customers(
        page,
        name,
        email,
      );

  Future<Response> customGroups() => _adminRepository.customGroups();

  Future<Response> addCustomer(AddCustomer customer) =>
      _adminRepository.addCustomer(customer);

  Future<Response> editCustomer(AddCustomer customer) =>
      _adminRepository.editCustomer(customer);

  Future<Response> deleteCustomerGroup(String customerId) =>
      _adminRepository.deleteCustomerGroup(customerId);

  Future<Response> deleteManufacturer(String customerId) =>
      _adminRepository.deleteManufacturer(customerId);

  Future<Response> deleteCustomer(String customerId) =>
      _adminRepository.deleteCustomer(customerId);

  Future<Response> orders(FilterOrders orders, String sort) =>
      _adminRepository.orders(orders, sort);

  Future<Response> orderStatus() => _adminRepository.orderStatus();

  Future<Response> adminOrderDetails(String orderId) =>
      _adminRepository.orderDetails(orderId);

  Future<Response> orderProducts(String orderId) =>
      _adminRepository.orderProducts(orderId);

  Future<Response> deleteOrder(String orderId) =>
      _adminRepository.deleteOrder(orderId);

  Future<Response> adminProducts(FilterProducts products, String sort) =>
      _adminRepository.adminProducts(products, sort);

  Future<Response> updateOrderStatus(String orderId, String statusId) =>
      _adminRepository.updateOrderStatus(orderId, statusId);
}
