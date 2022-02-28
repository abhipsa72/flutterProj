import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/model/country_code.dart';
import 'package:grand_uae/customer/model/zones_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  AddressBook _sendAddressBook = AddressBook();
  Country _country;
  List<Zone> _zones;
  Zone _selectedZone;
  String errorMessage;
  bool _isUseDefault = false;

  bool get isUseDefault => _isUseDefault;

  set isUseDefault(bool value) {
    _isUseDefault = value;
    notifyListeners();
  }

  AddressBook get sendAddressBook => _sendAddressBook;

  set sendAddressBook(AddressBook value) {
    _sendAddressBook = value;
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

  AddAddressModel() {
    fetchDetails();
  }

  Future fetchDetails() async {
    try {
      setState(ViewState.Busy);
      var result = await Future.wait([
        _repository.fetchZones(),
        _repository.fetchCountries(),
      ]);

      var countries = countryListFromMap(result[1].data).success.countries;
      if (countries.isNotEmpty) {
        country = countries.first;
      }

      var zonesList = zoneListFromMap(result[0].data).zones;
      if (zonesList.isNotEmpty) {
        zones = zonesList;
      }
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      showModel(
        "Something is wrong, please try",
        color: Colors.red,
      );
    }
  }

  Future<bool> addAddressBook() async {
    try {
      if (_country == null || _selectedZone == null) {
        showModel(
          "Please select region or country",
          color: Colors.red,
        );
        return false;
      }
      _sendAddressBook.countryId = _country.countryId;
      _sendAddressBook.zoneId = _selectedZone.zoneId;
      _sendAddressBook.useDefault = isUseDefault ? 1 : 0;

      setState(ViewState.Busy);
      var result = await _repository.addAddressBook(_sendAddressBook);
      setState(ViewState.Idle);

      if (result.data['success'] != null) {
        if (isUseDefault) {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString(
              selectedAddressId, result.data['address_id'].toString());
        }
        showModel(result.data['success']);
        return true;
      } else {
        return false;
      }
    } on DioError catch (error) {
      setState(ViewState.Error);
      showModel(
        dioError(error),
        color: Colors.red,
      );
      return false;
    } catch (error) {
      print(error);
      setState(ViewState.Error);
      showModel(
        "Something is wrong, please try",
        color: Colors.red,
      );
      return false;
    }
  }
}
