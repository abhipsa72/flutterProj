import 'package:dio/dio.dart';
import 'package:grand_uae/admin/model/category_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class CategoriesModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  List<Category> _customerList = [];
  String errorMessage = "";

  List<Category> get customerList => _customerList;

  set customerList(List<Category> value) {
    _customerList = value;
    notifyListeners();
  }

  CategoriesModel() {
    fetchCategories();
  }

  Future fetchCategories() async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.adminCategories();
      this.customerList =
          adminCategoriesFromMap(result.data).success.categories;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future deleteCategory(Category category) async {
    try {
      setState(ViewState.Busy);
      await _repository.deleteCategory(category.categoryId);
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
