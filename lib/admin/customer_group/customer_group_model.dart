import 'package:dio/dio.dart';
import 'package:grand_uae/admin/model/customer_group_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class CustomerGroupModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  List<CustomerGroup> _customerGroupList = [];
  String errorMessage = "";

  List<CustomerGroup> get customerGroupList => _customerGroupList;

  set customerGroupList(List<CustomerGroup> value) {
    _customerGroupList = value;
    notifyListeners();
  }

  CustomerGroupModel() {
    fetchCustomerGroups();
  }

  Future fetchCustomerGroups() async {
    try {
      setState(ViewState.Busy);
      var result = await _repository.customGroups();
      this.customerGroupList =
          customerGroupFromMap(result.data).success.customerGroups;
      setState(ViewState.Idle);
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
    } catch (error) {
      errorMessage = error.toString();
      setState(ViewState.Error);
    }
  }

  Future deleteCustomerGroup(CustomerGroup customer) async {
    try {
      setState(ViewState.Busy);
      await _repository.deleteCustomerGroup(customer.customerGroupId);
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
