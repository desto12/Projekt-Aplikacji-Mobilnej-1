import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rezerwacjakortow/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationCard extends StatefulWidget{
  final DateTime data;
  final int courtId;
  ReservationCard({Key key, this.data,this.courtId}) : super(key: key);

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
    final DateTime beginDate = widget.data.subtract(Duration(hours: 12));
    print(beginDate);
    final DateTime endDate = beginDate.add(Duration(hours: 22));
    print(endDate);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Kalendarz Rezerwacji"),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: DatabaseService().getReservations(widget.courtId,beginDate,endDate),
    builder: (context,snapshot) {
      if (!snapshot.hasData)
        return Text('ładowanie danych....');
      return ListView(children: getReservationDetails(snapshot),);
    }),
      //Text("OTO REZERWACJE KORTU $courtName: NA DZIEN: $dateString",style: TextStyle(fontSize: 32.0),),
    );
  }
  getReservationDetails(AsyncSnapshot<QuerySnapshot> snapshot) {



    return snapshot.data.documents
        .map((doc) => new ListTile(title: new Text(doc["name"],
    ),//doc['reservation_date'
      subtitle:Text("Rezerwacja na godzinę: " + doc['reservation_date'].toDate().toString()),
    )

    ).toList();
    //Text(DateFormat("hh:mm:ss")
    //                        .format(DateTime.fromMicrosecondsSinceEpoch(doc['reservation_date'] * 1000)).toString()
    //var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
  }
}