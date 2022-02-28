import 'package:dio/dio.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class AddressListModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Repository _repository = locator<Repository>();
  List<AddressBook> _addressBooks = [];
  AddressBook _defaultAddress;
  String errorMessage;

  AddressBook get defaultAddress => _defaultAddress;

  set defaultAddress(AddressBook value) {
    _defaultAddress = value;
    notifyListeners();
  }

  List<AddressBook> get addressBooks => _addressBooks;

  set addressBooks(List<AddressBook> value) {
    _addressBooks = value;
    notifyListeners();
  }

  AddressListModel() {
    fetchAccountDetails();
  }

  Future deleteAddress(AddressBook addressBook) async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.deleteAddress(addressBook.addressId);
      showModel(result.data['success']);
      setState(ViewState.Idle);
      fetchAccountDetails();
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      setState(ViewState.Idle);
      errorMessage = error.toString();
    }
  }

  Future fetchAccountDetails() async {
    try {
      setState(ViewState.Busy);
      final result = await _repository.fetchAccountDetails();
      var response = accountDetailsFromMap(result.data);
      var personalDetail = response.personalDetail;
      addressBooks = response.addressBook;
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(
        selectedAddressId,
        personalDetail.defaultAddressId,
      );
      _defaultAddress = addressBooks.firstWhere(
          (element) => element.addressId == personalDetail.defaultAddressId);
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      setState(ViewState.Idle);
      errorMessage = error.toString();
    }
  }

  Future setDefaultAddress(AddressBook address) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      setState(ViewState.Busy);
      address.useDefault = 1;
      var result = await _repository.updateAddressBook(address);
      showModel(result.data['success']);
      defaultAddress = address;
      prefs.setString(selectedAddressId, address.addressId);
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
    }
  }

  Future<bool> navigateToAddAddress() async {
    return await _navigationService.navigateTo(routes.AddAddressRoute);
  }

  Future<bool> navigateToEditAddress(AddressBook address) async {
    return await _navigationService.navigateTo(
      routes.EditAddressRoute,
      arguments: address.addressId,
    );
  }
}
