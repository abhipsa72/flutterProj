import 'package:dio/dio.dart';
import 'package:grand_uae/admin/model/add_category.dart';
import 'package:grand_uae/admin/model/add_customer.dart';
import 'package:grand_uae/admin/model/filter_products.dart';
import 'package:grand_uae/admin/orders/filter_orders.dart';
import 'package:grand_uae/network/dio_network.dart';

class AdminRepository {
  final DioNetworkUtil _dio;

  AdminRepository(this._dio);

  Future<Response> login(String username, String password) => _dio.postForm(
        "index.php?route=custom/admin/user/login",
        FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );

  Future<Response> categories() =>
      _dio.get("index.php?route=custom/admin/category");

  Future<Response> addCategory(AddCategory category) => _dio.postForm(
        "index.php?route=custom/admin/category/add",
        FormData.fromMap(category.toMap()),
      );

  Future<Response> editCategory(AddCategory category) => _dio.postForm(
        "index.php?route=custom/admin/category/edit",
        FormData.fromMap(category.toMap()),
      );

  Future<Response> deleteCategory(String categoryId) => _dio.deleteForm(
        "index.php?route=custom/admin/category/delete",
        FormData.fromMap({
          'category_id': categoryId,
        }),
      );

  Future<Response> customers(
    int page,
    String name,
    String email,
  ) =>
      _dio.get(
        "index.php?route=custom/admin/customer",
        params: {
          'limit': 30,
          'page': page,
          'order': 'ASC',
          'filter_name': name,
          'filter_email': email,
        },
      );

  Future<Response> addCustomer(AddCustomer customer) => _dio.postForm(
        "index.php?route=custom/admin/customer/add",
        FormData.fromMap(customer.toMap()),
      );

  Future<Response> editCustomer(AddCustomer customer) => _dio.postForm(
        "index.php?route=custom/admin/customer/edit",
        FormData.fromMap(customer.toMap()),
      );

  Future<Response> deleteCustomer(String categoryId) => _dio.deleteForm(
        "index.php?route=custom/admin/customer/delete",
        FormData.fromMap({
          'customer_id': categoryId,
        }),
      );

  Future<Response> customGroups() =>
      _dio.get("index.php?route=custom/admin/customer_group");

  Future<Response> deleteCustomerGroup(String categoryId) => _dio.deleteForm(
        "index.php?route:custom/admin/customer_group/delete",
        FormData.fromMap({
          'customer_id': categoryId,
        }),
      );

  Future<Response> fetchManufactures() =>
      _dio.get("index.php?route=custom/admin/manufacturing");

  Future<Response> deleteManufacturer(String manufactureId) => _dio.deleteForm(
        "index.php?route:custom/admin/manufacturing/delete",
        FormData.fromMap({
          'customer_id': manufactureId,
        }),
      );

  Future<Response> fetchAttributes() =>
      _dio.get("index.php?route=custom/admin/attribute");

  Future<Response> fetchAttribute(String attributeId) => _dio.get(
        "index.php?route:custom/admin/attribute/getAttribute",
        params: {
          'attribute_id': attributeId,
        },
      );

  Future<Response> deleteAttribute(String attributeId) => _dio.get(
        "index.php?route:custom/admin/attribute/delete",
        params: {
          'attribute_id': attributeId,
        },
      );

  Future<Response> orders(FilterOrders orders, String sort) => _dio.get(
        "index.php?route=custom/admin/order&sort=$sort",
        params: {
          'filter_order_status': orders.orderStatusId,
          'filter_customer': orders.customer,
          'filter_total': orders.amount,
          'filter_date_added': orders.dateAdded,
          'filter_date_modified': orders.dateModified,
          'page': orders.page,
          'limit': 30,
        },
      );

  Future<Response> orderStatus() =>
      _dio.get("index.php?route=custom/admin/order/getOrderStatus");

  Future<Response> orderDetails(String orderId) => _dio.get(
        "index.php?route=custom/admin/order/getOrder",
        params: {
          'order_id': orderId,
        },
      );

  Future<Response> updateOrderStatus(String orderId, String statusId) =>
      _dio.postForm(
        "index.php?route=custom/admin/order/updateOrderStatus",
        FormData.fromMap({
          'order_id': orderId,
          'order_status_id': statusId,
        }),
      );

  Future<Response> orderProducts(String orderId) => _dio.get(
        'index.php?route=custom/admin/order/getOrderProducts',
        params: {
          'order_id': orderId,
        },
      );

  Future<Response> deleteOrder(String orderId) => _dio.delete(
        'index.php?route=custom/admin/order/delete',
        params: {
          'order_id': orderId,
        },
      );

  Future<Response> adminProducts(
    FilterProducts products,
    String sort,
  ) =>
      _dio.get(
        "index.php?route=custom/admin/product&sort=$sort",
        params: products.toMap(),
      );
}
