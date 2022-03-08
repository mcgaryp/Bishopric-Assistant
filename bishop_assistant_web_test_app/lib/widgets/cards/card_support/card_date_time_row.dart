import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:intl/intl.dart';

///
/// CardDateTimeRow.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardDateTimeRow extends StatefulWidget {
  final DateTime? initialDateTime;
  final Function(DateTime) onChange;
  final TextStyle _style;
  final Color _iconColor;
  final bool dateOnly;

  const CardDateTimeRow(this.onChange,
      {this.dateOnly = false, this.initialDateTime, Key? key})
      : this._style = body,
        this._iconColor = dark,
        super(key: key);

  const CardDateTimeRow.light(this.onChange,
      {this.dateOnly = false, this.initialDateTime, Key? key})
      : this._style = bodyLight,
        this._iconColor = light,
        super(key: key);

  @override
  _CardDateTimeRowState createState() => _CardDateTimeRowState();
}

class _CardDateTimeRowState extends State<CardDateTimeRow> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    selectedDate = widget.initialDateTime ?? DateTime.now();
    selectedTime =
        TimeOfDay.fromDateTime(widget.initialDateTime ?? DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.MMMMEEEEd().format(selectedDate),
              style: widget._style,
              overflow: TextOverflow.ellipsis,
            ),
            MyButton.icon(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: widget._iconColor,
                ),
                onPressed: () => _showDatePicker(context)),
          ]),
      if (!widget.dateOnly)
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedTime.format(context),
                style: widget._style,
                overflow: TextOverflow.ellipsis,
              ),
              MyButton.icon(
                  icon: Icon(
                    Icons.access_time,
                    color: widget._iconColor,
                  ),
                  onPressed: () => _showTimePicker(context)),
            ])
    ]);
  }

  void _showDatePicker(BuildContext context) async {
    DateTime initialDate = selectedDate;
    DateTime firstDate = selectedDate.subtract(Duration(days: 1));
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
