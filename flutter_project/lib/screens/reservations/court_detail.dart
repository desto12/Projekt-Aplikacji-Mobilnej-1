import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rezerwacjakortow/services/database.dart';


class CourtDetail extends StatefulWidget {
  final String courtId;

  const CourtDetail({Key key, this.courtId}) : super(key: key);


  @override
  CourtDetailState createState() => CourtDetailState();



  }
  class CourtDetailState extends State<CourtDetail> {


    Completer<GoogleMapController> _controller = Completer();

    LatLng _center = LatLng(41.605563, 16.852967);
    List<Marker> _markers = [];

    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }


      @override
    void initState() {
      super.initState();

    }

    @override
    void dispose() {
      super.dispose();
    }


      @override
      Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            appBar: AppBar(
            backgroundColor: Colors.pinkAccent,
            title: Text("Szczegóły Kortu"),
        centerTitle: true,
        elevation: 0,
        ),
          body: StreamBuilder(
            stream: DatabaseService().getCourt(widget.courtId),
        builder: (context,snapshot) {
        if (!snapshot.hasData)
          return Text('ładowanie danych....');
        var court = snapshot.data;
        double lat =  court['geo'].longitude;
        double lng = court['geo'].latitude;
        _center = LatLng(lng,lat);
        addMarker();
        return Center(
         child: Card(
           child:Column(
             children: <Widget>[ SizedBox(
               height: 400,
               child: GoogleMap(
                 mapType: MapType.normal,
                 onMapCreated: _onMapCreated,
                 initialCameraPosition: CameraPosition(
                   target: _center,
                   zoom: 15.0,
                 ),
                 markers: Set.from(_markers),
               ),
             ),
               ListTile(
                 leading:Icon(Icons.place),
                 title: Text(court['court_name']),
                 subtitle: Text(court['Adres']),
               )
             ],
           ) ,
         ),
        );

        }),
            );
    }
    addMarker()
    {
      _markers.add(Marker(
        markerId:MarkerId('1'),
        draggable: false,
        position:_center,
      ),
      );
    }
    }