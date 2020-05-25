import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rezerwacjakortow/services/database.dart';
import 'package:rezerwacjakortow/screens/reservations/reservation_form.dart';
import 'package:rezerwacjakortow/screens/auth.dart';

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
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReservationForm(data: beginDate,courtId: widget.courtId,),
            ),);
        },
        child: Icon(Icons.add_circle),
        backgroundColor: Colors.pinkAccent,
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
      subtitle:Text("Rezerwacja od godziny: " + doc['reservation_date'].toDate().toString() + ' Do godziny: ' +doc['end_date'].toDate().toString()),
    onLongPress: () async{
          print(await Auth().currentUser());
          if( await Auth().currentUser() == doc.data['uid'])
            return DatabaseService().deleteItem(doc.documentID);
          else return Text('To nie twoja rezerwacja!');
        }
    ),
    ).toList();
    //Text(DateFormat("hh:mm:ss")
    //                        .format(DateTime.fromMicrosecondsSinceEpoch(doc['reservation_date'] * 1000)).toString()
    //var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
  }

}