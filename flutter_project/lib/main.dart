import 'package:flutter/material.dart';
import 'package:rezerwacjakortow/screens/home.dart';
import 'package:rezerwacjakortow/screens/reservations/reservation_card.dart';
import 'package:rezerwacjakortow/screens/reservations/reservations.dart';
import 'package:rezerwacjakortow/screens/root_page.dart';
import 'package:rezerwacjakortow/screens/auth.dart';
import 'package:rezerwacjakortow/screens/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Rezerwacja Kortu';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
    child: MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: {
        '/':(context) => RootPage(),
        '/home':(context) => Home(),
        '/reservations':(context) => Reservation(),
        '/reservation_card':(context) => ReservationCard(),
      },
    ),
    );
  }
}
