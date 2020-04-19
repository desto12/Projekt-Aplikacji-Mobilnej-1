import 'package:flutter/material.dart';

class ReservationCard extends StatefulWidget{
  final DateTime data;
  ReservationCard({Key key, this.data}) : super(key: key);

  @override
  ReservationCardState createState() => ReservationCardState();

}
class ReservationCardState extends State<ReservationCard> {

  @override
  void initState()
  {
    super.initState();
  }
  @override


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Kalendarz Rezerwacji"),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }}