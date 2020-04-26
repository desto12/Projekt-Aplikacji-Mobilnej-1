import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rezerwacjakortow/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CourtCard extends StatefulWidget{
  @override
  CourtCardState createState() => CourtCardState();


}
class CourtCardState extends State<CourtCard> {

  @override
  void initState()
  {
    super.initState();
  }


Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.pinkAccent,
      title: Text("Wybór kortu"),
      centerTitle: true,
      elevation: 0,
    ),
      body:StreamBuilder(
        stream: Firestore.instance.collection('Korty').snapshots(),
    builder: (context,snapshot){
          if(!snapshot.hasData)
              return Text('ładowanie danych....');
          return Column(
            children: <Widget>[
              RaisedButton(
                child: Text(snapshot.data.documents[0]['court_name']),
                onPressed:(){Navigator.pushNamed(context, "/reservations");
                },
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                ),
                color:Color(0xfff50057),
              ),
              RaisedButton(
                child: Text(snapshot.data.documents[1]['court_name']),
                onPressed:(){Navigator.pushNamed(context, "/reservations");
                },
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                ),
                color:Color(0xfff50057),
              ),
            ],

          );
    }
      ),
    );
  }
  /*  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("expenses").snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("There is no expense");
          return new ListView(children: getExpenseItems(snapshot));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new ListTile(title: new Text(doc["name"]), subtitle: new Text(doc["amount"].toString())))
        .toList();
  }*/
}