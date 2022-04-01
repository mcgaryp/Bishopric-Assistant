import 'package:the_assistant/widgets/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

///
/// my_calendar.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/7/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MyCalendar extends StatefulWidget {
  final List<CalendarEvent> items;

  const MyCalendar(this.items, {Key? key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime focusedDay = DateTime.now();
  late DateTime selectedDay;
  late final ValueNotifier<List<CalendarEvent>> selectedEvents;

  @override
  void initState() {
    super.initState();

    selectedDay = focusedDay;
    selectedEvents = ValueNotifier(getEventsForDay(selectedDay));
  }

  @override
  void dispose() {
    selectedEvents.dispose();
    super.dispose();
  }

  List<CalendarEvent> getEventsForDay(DateTime day) {
    return widget.items
        .where((CalendarEvent element) => isSameDay(element.date, day))
        .toList();
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedDay, selected)) {
      setState(() {
        selectedDay = selected;
        focusedDay = focused;
      });
    }
    selectedEvents.value = getEventsForDay(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: focusedDay,
          lastDay: DateTime.now().add(Duration(days: 31)),
          firstDay: DateTime.now(),
          selectedDayPredicate: (DateTime day) => isSameDay(selectedDay, day),
          calendarFormat: CalendarFormat.month,
          onFormatChanged: (CalendarFormat format) {},
          onDaySelected: onDaySelected,
          eventLoader: getEventsForDay,
        ),
        ValueListenableBuilder<List<CalendarEvent>>(
            valueListenable: selectedEvents,
            builder: (context, value, _) {
              return Column(
                  children: value
                      .map((e) => ListTile(
                            title: Text('$e', style: body),
                          ))
                      .toList());
            }),
      ],
    );
  }
}

abstract class CalendarEvent {
  final DateTime date;
  final String title;

  CalendarEvent(this.date, this.title);

  @override
  String toString() {
    return title;
  }
}
