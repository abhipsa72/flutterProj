import 'package:flutter/material.dart';
import 'package:zel_app/model/selected_dates.dart';

class ManagingDirectorCommon extends ChangeNotifier {
  SelectedDates _selectedDates = SelectedDates();

  SelectedDates get selectedDates => _selectedDates;
  setFromAndEndDates(SelectedDates selectedDates) {
    this._selectedDates = selectedDates;
    notifyListeners();
  }
}
