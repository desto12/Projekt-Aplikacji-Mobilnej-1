import 'package:flutter/material.dart';
import 'package:rezerwacjakortow/screens/home.dart';
import 'package:rezerwacjakortow/screens/reservations/reservations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Rezerwacja Kortu';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Reservation(title: appTitle),
    );
  }
}
