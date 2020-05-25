import 'package:flutter/material.dart';
import 'package:rezerwacjakortow/screens/reservations/reservation_card.dart';
import 'package:table_calendar/table_calendar.dart';


class Reservation extends StatefulWidget {
  Reservation({Key key, this.title,this.courtId}) :super(key: key);
  final String title;
  final int courtId;
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
  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: "/reservation_card"),
        builder: (context) => ReservationCard(data: day,courtId: widget.courtId,),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    print(widget.courtId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalendarz Rezerwacji"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body:TableCalendar(
      calendarController: _calendarController,
        availableCalendarFormats: const {
        CalendarFormat.month: 'Week'
        },
        onDaySelected: _onDaySelected,

    ),
    );
  }
}
