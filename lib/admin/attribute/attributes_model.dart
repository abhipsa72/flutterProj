import 'package:dio/dio.dart';
import 'package:grand_uae/admin/model/attributes_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class AttributesModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  List<Attribute> _attributes = [];
  String errorMessage = "";

  List<Attribute> get attributes => _attributes;

  set attributes(List<Attribute> value) {
    _attributes = value;
    notifyListeners();
  }

  AttributesModel() {
    fetchCategories();
  }

  Future fetchCategories() async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.fetchAttributes();
      this.attributes = attributesFromMap(result.data).success.attributes;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future deleteAttribute(Attribute attribute) async {
    try {
      setState(ViewState.Busy);
      await _repository.deleteAttribute(attribute.attributeId);
      //this.customerList = adminCategoriesFromMap(result.data).success.categories;
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
