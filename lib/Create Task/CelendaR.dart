import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/entryprovider.dart';

class DueDate extends StatefulWidget {
  @override
  _DueDateState createState() => _DueDateState();
}

class _DueDateState extends State<DueDate> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String due;

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context);
    due = DateFormat("yyyy-MM-dd ").format(selectedDate) +
        selectedTime.hour.toString() +
        ":" +
        selectedTime.minute.toString() +
        ":00";
    entryProvider.changeDate = due;
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.date_range_rounded,
              size: 40,
              color: Colors.teal[700],
            ),
            onPressed: () async {
              final selectedDate = await _selectdate(context);
              if (selectedDate == null)
                return;
              else {
                selectedTime = await _selecttime(context);
                print(selectedTime);
              }
              setState(() {
                this.selectedDate = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                );
                this.selectedTime = TimeOfDay(
                    hour: selectedTime.hour, minute: selectedTime.minute);
                print(selectedDate);
                print(selectedTime);

                due = DateFormat("yyyy-MM-dd ").format(selectedDate) +
                    selectedTime.hour.toString() +
                    ":" +
                    selectedTime.minute.toString() +
                    ":00";
              });
              entryProvider.changeDate = due;
            },
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            DateFormat("EEE   dd/MM/yyyy  ").format(selectedDate) +
                "Time : " +
                selectedTime.hour.toString() +
                " : " +
                selectedTime.minute.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Future<DateTime> _selectdate(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));
  }

  Future<TimeOfDay> _selecttime(BuildContext context) {
    return showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
  }
}
