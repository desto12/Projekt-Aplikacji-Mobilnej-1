import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rezerwacjakortow/screens/reservations/court_detail.dart';
import 'package:rezerwacjakortow/screens/reservations/reservations.dart';
import 'package:rezerwacjakortow/services/database.dart';


class CourtCard extends StatefulWidget {
  @override
  CourtCardState createState() => CourtCardState();


}
class CourtCardState extends State<CourtCard> with TickerProviderStateMixin {
AnimationController _controll;
Animation<double> animation;
Tween<double> tween;

bool isPlaying = false;
  @override
  void initState ()
  {
    super.initState();
    _controll = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    tween = Tween(begin: 1.0, end: 0.0);
     animation = tween.animate(_controll);
     _controll.forward();
  }
  @override
void dispose() {
    _controll.dispose();
  super.dispose();
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
        stream: DatabaseService().getPost('Korty'),
    builder: (context,snapshot) {
      if (!snapshot.hasData)
        return Text('ładowanie danych....');
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing:AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  progress: animation,
              ),
              onLongPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourtDetail(courtId: snapshot.data[index].documentID),
                  ),);
              },
              title: Text(snapshot.data[index].data['court_name']),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(
                  builder: (context) => Reservation(courtId: snapshot.data[index].data['court_id'])
                ),
                );
              },
            );
          });
    }),
    );
  }

}