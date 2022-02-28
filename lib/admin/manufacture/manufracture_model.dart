import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grand_uae/admin/model/manufacture_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class ManufacturesModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  List<Manufacturer> _manufacturers = [];
  String errorMessage = "";

  List<Manufacturer> get manufacturers => _manufacturers;

  set manufacturers(List<Manufacturer> value) {
    _manufacturers = value;
    notifyListeners();
  }

  ManufacturesModel() {
    fetchManufactures();
  }

  Future fetchManufactures() async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.fetchManufactures();
      var manufacturers =
          manufactureFromMap(json.decode(result.data)).success.manufacturers;
      manufacturers.sort((a, b) => a.name.compareTo(b.name));
      this.manufacturers = manufacturers;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future deleteManufacture(Manufacturer manufacturer) async {
    try {
      setState(ViewState.Busy);
      await _repository.deleteManufacturer(manufacturer.manufacturerId);
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }
}
