import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/model/country_code.dart';
import 'package:grand_uae/customer/model/shipping_address.dart';
import 'package:grand_uae/customer/model/shipping_method.dart';
import 'package:grand_uae/customer/model/zones_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class ShippingAddressViewModel extends BaseViewModel {
  final Repository _repository = Repository();
  final BuildContext _context;
  final NavigationService _navigationService = locator<NavigationService>();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final addressNode = FocusNode();
  final address2Node = FocusNode();
  final cityNode = FocusNode();
  final postNode = FocusNode();
  String errorMessage = "";
  AddressBook _addressBook;

  List<AddressBook> _addressBooks = [];
  ShippingAddress shippingAddress;
  Country _country;
  List<Zone> _zones;
  Zone _selectedZone;
  List<ShippingMethod> _shippingMethods;
  String message;
  bool _isUseDefault = false;

  List<AddressBook> get addressBooks => _addressBooks;

  set addressBooks(List<AddressBook> value) {
    _addressBooks = value;
    notifyListeners();
  }

  bool get isUseDefault => _isUseDefault;

  set isUseDefault(bool value) {
    _isUseDefault = value;
    notifyListeners();
  }

  AddressBook get addressBook => _addressBook;

  set addressBook(AddressBook value) {
    _addressBook = value;
    notifyListeners();
  }

  List<ShippingMethod> get shippingMethods => _shippingMethods;

  set shippingMethods(List<ShippingMethod> value) {
    _shippingMethods = value;
    notifyListeners();
  }

  Zone get selectedZone => _selectedZone;

  set selectedZone(Zone zone) {
    this._selectedZone = zone;
    notifyListeners();
  }

  Country get country => _country;

  set country(Country country) {
    this._country = country;
    notifyListeners();
  }

  List<Zone> get zones => _zones;

  set zones(List<Zone> value) {
    _zones = value;
    notifyListeners();
  }

  ShippingAddressViewModel(this._context) {
    refresh();
  }

  refresh() {
    fetchDetails();
  }

  Future setAddressToOrder() async {
    if (_country == null || _selectedZone == null) {
      showModel("Please select region or country", color: Colors.red);
      return;
    }
    final prefs = await SharedPreferences.getInstance();

    shippingAddress = ShippingAddress(
      firstName: prefs.getString(firstName) ?? "test",
      lastName: prefs.getString(lastName) ?? "test",
      address1: address1Controller.text,
      address2: address2Controller.text,
      city: cityController.text,
      countryId: _country.isoCode3,
      zoneId: _selectedZone.code,
      postCode: postalCodeController.text,
      isDefault: isUseDefault,
    );
    setState(ViewState.Busy);
    try {
      await _repository.setShippingAddress(shippingAddress);
      fetchShippingMethods();
      //setState(ViewState.Idle);
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

  Future fetchShippingMethods() async {
    try {
      setState(ViewState.Busy);
      final result = await _repository.shippingMethods();
      shippingMethods = shippingMethodsFromJson(result.data).shippingMethods;
      checkShippingMethod();
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

  Future setShippingMethod(String method) async {
    setState(ViewState.Busy);
    try {
      await _repository.setShippingMethod(method);
      setState(ViewState.Idle);
      setPaymentAddress(shippingAddress);
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

  void setAddressAndGo() {
    setPaymentAddress(shippingAddress);
  }

  Future setPaymentAddress(ShippingAddress address) async {
    setState(ViewState.Busy);
    try {
      await _repository.setPaymentAddress(shippingAddress);
      setState(ViewState.Idle);
      _navigationService.navigateTo(routes.PaymentRoute);
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

  void checkShippingMethod() {
    if (_shippingMethods.isEmpty) {
      showDialog(
        context: _context,
        builder: (_) {
          return AlertDialog(
            title: Text("Alert!"),
            content: Text("Shipping methods are not available"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(_context);
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    } else {
      showShippingMethodsDialog();
    }
  }

  void showShippingMethodsDialog() {
    showDialog(
      context: _context,
      builder: (_) {
        return AlertDialog(
          title: Text("Shipping methods"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemBuilder: (_, index) {
                ShippingMethod method = _shippingMethods[index];
                return ListTile(
                  title: Text("${method.quote.title} ${method.quote.text}"),
                  onTap: () {
                    setShippingMethod(method.quote.code);
                    Navigator.pop(_context);
                  },
                );
              },
              itemCount: _shippingMethods.length,
              shrinkWrap: true,
            ),
          ),
        );
      },
    );
  }

  Future fetchDetails() async {
    var prefs = await SharedPreferences.getInstance();
    var addressId = prefs.getString(selectedAddressId) ?? "";
    try {
      setState(ViewState.Busy);
      var result = await Future.wait([
        _repository.fetchAccountDetails(),
        _repository.fetchZones(),
        _repository.fetchCountries(),
      ]);

      var addressBookList = accountDetailsFromMap(result[0].data).addressBook;
      addressBooks = addressBookList;
      var findAddress = addressBookList.firstWhere(
        (element) => element.addressId == addressId,
        orElse: () => null,
      );
      if (findAddress != null) {
        addressBook = findAddress;
      } else {
        addressBook = null;
      }

      var zonesList = zoneListFromMap(result[1].data).zones;
      if (zonesList.isNotEmpty) {
        zones = zonesList;
      }
      var countries = countryListFromMap(result[2].data).success.countries;
      if (countries.isNotEmpty) {
        country = countries.first;
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

  Future setSelectedAddressToOrder(AddressBook addressBook) async {
    shippingAddress = ShippingAddress(
      firstName: addressBook.firstname,
      lastName: addressBook.lastname,
      address1: addressBook.address1,
      address2: addressBook.address2,
      city: addressBook.city,
      countryId: addressBook.countryId,
      zoneId: addressBook.zoneId,
      postCode: addressBook.postcode,
    );

    try {
      setState(ViewState.Busy);
      await _repository.setShippingAddress(shippingAddress);
      fetchShippingMethods();
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

  Future setDefaultAddressToOrder() async {
    shippingAddress = ShippingAddress(
      firstName: addressBook.firstname,
      lastName: addressBook.lastname,
      address1: addressBook.address1,
      address2: addressBook.address2,
      city: addressBook.city,
      countryId: addressBook.countryId,
      zoneId: addressBook.zoneId,
      postCode: addressBook.postcode,
      isDefault: false,
    );

    try {
      setState(ViewState.Busy);
      await _repository.setShippingAddress(shippingAddress);
      fetchShippingMethods();
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
}
