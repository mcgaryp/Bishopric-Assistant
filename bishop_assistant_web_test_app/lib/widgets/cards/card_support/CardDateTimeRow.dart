import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardIconButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// CardDateTimeRow.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardDateTimeRow extends StatefulWidget {
  const CardDateTimeRow({Key? key}) : super(key: key);

  @override
  _CardDateTimeRowState createState() => _CardDateTimeRowState();
}

class _CardDateTimeRowState extends State<CardDateTimeRow> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Container(
        decoration: inputOnLightDecoration,
        child: Padding(
          padding: const EdgeInsets.all(padding8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat.MMMMEEEEd().format(selectedDate),
                  style: bodyStyle),
              CardIconButton(Icons.calendar_today_outlined,
                  onPressed: () => _showDatePicker(context)),
              Text(selectedTime.format(context), style: bodyStyle),
              CardIconButton(Icons.access_time,
                  onPressed: () => _showTimePicker(context))
              // InputDatePickerFormField(firstDate: DateTime.now(), lastDate: DateTime(2030))
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime initialDate = selectedDate;
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(2030);
    DateTime? pick = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,

    );

    if (pick != null && pick != selectedDate)
      setState(() {
        selectedDate = DateTime(
            pick.year, pick.month, pick.day, selectedTime.hour,
            selectedTime.minute);
      });
  }

  void _showTimePicker(BuildContext context) async {
    TimeOfDay initialTime = selectedTime;
    TimeOfDay? pick = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);

    if (pick != null && pick != selectedTime)
      setState(() {
        selectedTime = pick;
        selectedDate = DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day,
            selectedTime.hour, selectedTime.minute);
      });
  }
}
