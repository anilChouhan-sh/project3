import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DueDate extends StatefulWidget {
  @override
  _DueDateState createState() => _DueDateState();
}

class _DueDateState extends State<DueDate> {
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
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
              if (selectedDate == null) return;
              print(selectedDate);

              setState(() {
                this.selectedDate = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                );
              });
            },
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            DateFormat("yyyy-MM-dd").format(selectedDate),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Future<DateTime> _selectdate(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2021));
  }
}
