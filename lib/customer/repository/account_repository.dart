import 'package:dio/dio.dart';
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/network/dio_network.dart';

class AccountRepository {
  final DioNetworkUtil _dio;

  AccountRepository(this._dio);

  Future<Response> fetchAccountDetails() =>
      _dio.get("index.php?route=custom/account");

  Future<Response> deleteAccount(String addressId) => _dio.delete(
        "index.php?route=custom/address/delete",
        params: {'address_id': addressId},
      );

  Future<Response> addAddressBook(AddressBook sendAddressBook) => _dio.postForm(
        "index.php?route=custom/address/add",
        FormData.fromMap(
          sendAddressBook.toMap(),
        ),
      );

  Future<Response> updateAddressBook(AddressBook sendAddressBook) =>
      _dio.postForm(
        "index.php?route=custom/address/edit",
        FormData.fromMap(
          sendAddressBook.toMap(),
        ),
      );

  Future<Response> updateUserDetails(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
  ) =>
      _dio.postForm(
        "index.php?route=custom/account/edit",
        FormData.fromMap({
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'telephone': phoneNumber,
        }),
      );

  Future<Response> updatePassword(
    String password,
    String confirmPassword,
  ) =>
      _dio.postForm(
        "index.php?route=custom/account/updatePassword",
        FormData.fromMap({
          'password': password,
          'confirm': confirmPassword,
        }),
      );
}
