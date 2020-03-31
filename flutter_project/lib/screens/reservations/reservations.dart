import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Reservation extends StatefulWidget {
  Reservation({Key key, this.title}) :super(key: key);
  final title;
  @override
  _ReservationState createState() => _ReservationState();
}



class _ReservationState extends State<Reservation> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TableCalendar(
      calendarController: _calendarController,
        availableCalendarFormats: const {
        CalendarFormat.month: 'Week'
        },
    ),
    );
  }
}
