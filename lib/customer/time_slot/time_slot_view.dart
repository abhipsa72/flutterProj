import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/model/time_slots_response.dart';
import 'package:grand_uae/customer/time_slot/time_slot_model.dart';
import 'package:provider/provider.dart';

class TimeSlotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery time slot"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<TimeSlotModel>(
          builder: (context, model, Widget child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: model.controller,
                        decoration: InputDecoration(
                          hintText: "Delivery Date",
                          labelText: "Delivery Date",
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          helpText: "Select delivery date",
                          initialDatePickerMode: DatePickerMode.day,
                          lastDate: DateTime.now().add(
                            Duration(
                              days: 3000,
                            ),
                          ),
                        );
                        if (picked != null && picked != model.selectedDate) {
                          model.selectedDate = picked;
                          model.controller.text = model.getDateTime();
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Builder(
                  builder: (_) {
                    if (model.timeSlots == null || model.timeSlots.isEmpty) {
                      return Container();
                    }
                    return DropdownButtonFormField<Timeslot>(
                      value: model.selectedTimeSlot,
                      hint: Text("Timeslot"),
                      decoration: InputDecoration(
                        labelText: "Delivery Slot",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).highlightColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: model.timeSlots.map((e) {
                        return DropdownMenuItem(
                          child: Text(e.text),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (Timeslot value) {
                        model.selectedTimeSlot = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  disabledColor: Colors.grey,
                  color: Theme.of(context).accentColor,
                  padding: const EdgeInsets.all(16.0),
                  onPressed: model.state == ViewState.Idle
                      ? () {
                          model.navigatePlaceOrder();
                        }
                      : null,
                  child: model.state == ViewState.Idle
                      ? Text(
                          "Place order".toUpperCase(),
                          style: TextStyle(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.grey[600],
                                ),
                                strokeWidth: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                "Loading",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
