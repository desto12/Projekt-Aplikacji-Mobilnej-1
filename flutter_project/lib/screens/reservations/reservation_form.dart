import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rezerwacjakortow/screens/auth.dart';
import 'package:rezerwacjakortow/services/database.dart';
class ReservationForm extends StatefulWidget{
  final DateTime data;
  final int courtId;
  ReservationForm({Key key, this.data,this.courtId}) : super(key: key);

  @override
  ReservationFormState createState() => ReservationFormState();

}
class ReservationFormState extends State<ReservationForm> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  String _name = '';
  DateTime startDate;
  DateTime endDate;
  double _duration;
  double _hvalue = 1;
  double _mvalue = 0;
  final user = Auth().userName();


  @override
  void initState()
  {

    super.initState();

  }
  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(context: context, initialTime: _time);
    setState(() {
      _time = picked;
    });
    }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    startDate = DateTime(widget.data.year,widget.data.month,widget.data.day,_time.hour,_time.minute);
    endDate = DateTime(widget.data.year,widget.data.month,widget.data.day,_time.hour + _hvalue.toInt(),_time.minute + _mvalue.toInt());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Kalendarz Rezerwacji"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child:Row(children: <Widget>[
                SizedBox(
                  child: Text('Wybierz godzinę'),
                ),
                IconButton(
                  icon: Icon(Icons.alarm),
                  onPressed: () => selectTime(context),
                ),
              ],)
            ),
            Slider( //hours
              value: _hvalue,
              min: 1,
              max: 14,
              divisions: 13,
              label: '$_hvalue',
              onChanged: (value) {
                setState(
                      () {
                    _hvalue = value;
                  },
                );
              },
            ),
            Slider( //minutes
              value: _mvalue,
              min: 0,
              max: 60,
              divisions: 4,
              label: '$_mvalue',
              onChanged: (value) {
                setState(
                      () {
                    _mvalue = value;
                  },
                );
              },
            ),
            Text('Rezerwacja do: '+ endDate.hour.toString()+':'+endDate.minute.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                // ignore: missing_return
                onPressed: () async{
                  _name = await user;
                  var _uid = await Auth().currentUser();
                  List<bool> list = await DatabaseService().checkIsFree2(
                      widget.courtId, endDate, startDate);
                  if (_formKey.currentState.validate()) {
                    // ignore: missing_return
                      if (list[0] && list[1]) {
                        DatabaseService().addItem(_uid,widget.courtId, _name,
                            startDate, endDate);
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                // ignore: missing_return
                                title: Text('Dodano rezerwacje!'),
                                content: Text(
                                    'Rezerwacja została dodana pomyśnie.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .popUntil(ModalRoute.withName("/reservation_card"));
                                    },
                                  )
                                ],
                              ),
                        );
                      }
                      else
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                // ignore: missing_return
                                title: Text('Wybierz inny termin!'),
                                content: Text(
                                    'W tym czasie kort jest zajęty, wybierz inny termin'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                        );
                        }
                  print(await DatabaseService().checkIsFree2(
                    // ignore: missing_return
                      widget.courtId, endDate, startDate));},
                child: Text('Dodaj'),
              ),
            ),
          ],
        ),
      ),
    );

  }

  }