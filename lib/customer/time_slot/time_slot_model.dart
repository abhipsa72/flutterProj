import 'package:flutter/cupertino.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/enums/time_slot_mode.dart';
import 'package:grand_uae/customer/model/send_time_slot.dart';
import 'package:grand_uae/customer/model/time_slots_response.dart';
import 'package:grand_uae/customer/repository/repository.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class TimeSlotModel extends BaseViewModel {
  final Repository _repository = locator<Repository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController controller = TextEditingController();
  TimeSlotMode mode;
  List<Timeslot> _timeSlots;
  Timeslot _selectedTimeSlot;
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  Timeslot get selectedTimeSlot => _selectedTimeSlot;

  set selectedTimeSlot(Timeslot value) {
    _selectedTimeSlot = value;
    notifyListeners();
  }

  List<Timeslot> get timeSlots => _timeSlots;

  set timeSlots(List<Timeslot> value) {
    _timeSlots = value;
    notifyListeners();
  }

  TimeSlotModel() {
    fetchTimeSlots();
  }

  String getDateTime() => "${selectedDate.toLocal()}".split(' ')[0];

  Future fetchTimeSlots() async {
    setState(ViewState.Busy);
    try {
      var result = await _repository.timeSlots();
      var timeSlots = timeSlotsFromMap(result.data).timeslots;
      this.timeSlots = timeSlots;
      setState(ViewState.Idle);
    } catch (error) {
      setState(ViewState.Error);
    }
  }

  void navigatePlaceOrder() {
    _navigationService.navigateTo(
      routes.PlaceOrderRoute,
      arguments: SelectTimeSlot(
        date: getDateTime(),
        time: selectedTimeSlot.key,
      ),
    );
  }

  Future setTimeSlot() async {
    setState(ViewState.Busy);
    try {
      var result = await _repository.setTimeSlot(
        getDateTime(),
        selectedTimeSlot.key,
      );
      this.timeSlots = timeSlotsFromMap(result.data).timeslots;
      setState(ViewState.Idle);
      _navigationService.navigateTo(routes.PlaceOrderRoute);
    } catch (error) {
      setState(ViewState.Error);
    }
  }
}
