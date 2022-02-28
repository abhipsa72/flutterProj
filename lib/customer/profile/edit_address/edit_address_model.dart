import 'package:dio/dio.dart';
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

class EditAddressModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final String _addressId;
  AddressBook _sendAddressBook = AddressBook();
  Country _country;
  List<Zone> _zones;
  Zone _selectedZone;
  String message;
  bool _isUseDefault = false;
  String errorMessage;

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

  EditAddressModel(this._addressId) {
    fetchDetails();
  }

  Future fetchDetails() async {
    try {
      setState(ViewState.Busy);
      var result = await Future.wait([
        _repository.fetchAccountDetails(),
        _repository.fetchZones(),
        _repository.fetchCountries(),
      ]);

      var addressBookList = accountDetailsFromMap(result[0].data).addressBook;
      var findAddress = addressBookList.firstWhere(
        (element) => element.addressId == _addressId,
        orElse: null,
      );
      if (findAddress != null) {
        sendAddressBook = findAddress;
      }

      var zonesList = zoneListFromMap(result[1].data).zones;
      if (zonesList.isNotEmpty) {
        zones = zonesList;
        selectedZone = zonesList.firstWhere(
          (element) => element.zoneId == sendAddressBook.zoneId,
          orElse: null,
        );
      }
      var countries = countryListFromMap(result[2].data).success.countries;
      if (countries.isNotEmpty) {
        country = countries.first;
      }
      setState(ViewState.Idle);
    } on DioError catch (error) {
      message = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      message = error.toString();
      setState(ViewState.Error);
      showModel("Something is wrong, please try");
    }
  }

  Future<bool> updateAddressBook(String addressId) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      setState(ViewState.Busy);
      if (_country == null || _selectedZone == null) {
        showModel("Please select region or country");
        return false;
      }
      _sendAddressBook.countryId = _country.countryId;
      _sendAddressBook.zoneId = _selectedZone.zoneId;
      _sendAddressBook.useDefault = isUseDefault ? 1 : 0;
      if (isUseDefault) {
        prefs.setString(selectedAddressId, _sendAddressBook.addressId);
      }
      var result = await _repository.updateAddressBook(_sendAddressBook);
      showModel(result.data['success']);
      setState(ViewState.Idle);
      return true;
    } on DioError catch (error) {
      showModel(dioError(error));
      setState(ViewState.Error);
      return true;
    } catch (error) {
      setState(ViewState.Error);
      showModel("Something is wrong, please try");
      return false;
    }
  }
}
