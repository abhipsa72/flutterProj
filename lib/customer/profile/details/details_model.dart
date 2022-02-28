import 'package:dio/dio.dart';
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/grand_exception.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:grand_uae/viewmodels/base_model.dart';

class DetailModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  PersonalDetail _detail;
  String errorMessage;

  PersonalDetail get detail => _detail;

  set detail(PersonalDetail value) {
    _detail = value;
    notifyListeners();
  }

  ProfileEditMode _editMode = ProfileEditMode.View;

  ProfileEditMode get editMode => _editMode;

  set editMode(ProfileEditMode value) {
    _editMode = value;
    notifyListeners();
  }

  DetailModel() {
    fetchAccountDetails();
  }

  Future fetchAccountDetails() async {
    try {
      setState(ViewState.Busy);
      final result = await _repository.fetchAccountDetails();
      var response = accountDetailsFromMap(result.data);
      detail = response.personalDetail;
      setState(ViewState.Idle);
    } catch (error) {
      print(error);
      setState(ViewState.Error);
    }
  }

  Future<bool> updateUserDetails() async {
    setState(ViewState.Busy);
    try {
      var result = await _repository.updateUserDetails(
        firstName,
        lastName,
        email,
        phoneNumber,
      );
      showModel(result.data['success']);
      setState(ViewState.Idle);
      return true;
    } on DioError catch (error) {
      errorMessage = dioError(error);
      setState(ViewState.Error);
      return false;
    } catch (error) {
      setState(ViewState.Error);
      errorMessage = error.toString();
      return false;
    }
  }
}

enum ProfileEditMode { Edit, View }
