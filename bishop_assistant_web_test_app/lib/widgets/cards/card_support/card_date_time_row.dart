import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widgets.dart';

///
/// CardDateTimeRow.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardDateTimeRow extends StatefulWidget {
  final Function(DateTime) onChange;

  const CardDateTimeRow(this.onChange, {Key? key}) : super(key: key);

  @override
  _CardDateTimeRowState createState() => _CardDateTimeRowState();
}

class _CardDateTimeRowState extends State<CardDateTimeRow> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      List<Widget> children = [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat.MMMMEEEEd().format(selectedDate), style: bodyDark),
            CardIconButton(Icons.calendar_today_outlined,
                onPressed: () => _showDatePicker(context)),
          ],
        ),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedTime.format(context), style: bodyDark),
              CardIconButton(Icons.access_time,
                  onPressed: () => _showTimePicker(context)),
            ])
      ];

      Widget child;

      switch (size.deviceScreenType) {
        case DeviceScreenType.mobile:
        case DeviceScreenType.tablet:
          child = Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          );
          break;
        case DeviceScreenType.desktop:
        default:
          child = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children);
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: padding8),
        child: Container(
          decoration: darkBorderBox,
          child: Padding(padding: const EdgeInsets.all(padding8), child: child),
        ),
      );
    });
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

    if (pick != null && pick != selectedDate) {
      setState(() {
        selectedDate = DateTime(pick.year, pick.month, pick.day,
            selectedTime.hour, selectedTime.minute);
        widget.onChange(selectedDate);
      });
    }
  }

  void _showTimePicker(BuildContext context) async {
    TimeOfDay initialTime = selectedTime;
    TimeOfDay? pick = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);

    if (pick != null && pick != selectedTime) {
      setState(() {
        selectedTime = pick;
        selectedDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedTime.hour, selectedTime.minute);
        widget.onChange(selectedDate);
      });
    }
  }
}
