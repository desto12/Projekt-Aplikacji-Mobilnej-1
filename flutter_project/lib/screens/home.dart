import 'package:flutter/material.dart';
import 'package:rezerwacjakortow/screens/auth.dart';
import 'package:rezerwacjakortow/screens/auth_provider.dart';

class Home extends StatelessWidget {
  const Home ({this.onSignedOut});
  final VoidCallback onSignedOut;

  Future<String> _currentUser(BuildContext context) async
  {
    final BaseAuth auth = AuthProvider.of(context).auth;
    final userMail = auth.userName();
    print(userMail.toString());
    return userMail;
  }
  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final String = _currentUser(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Rezerwacja krotów'),
        actions: <Widget>[
          FlatButton(
            child: Text('Wyloguj', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: Container(
        child: Center(child: Text('Witaj w tym miejscu bedą pojawiać się newsy', style: TextStyle(fontSize: 32.0))),
      ),
      drawer:Drawer(
    child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
    DrawerHeader(
    child: Text('Menu'),
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
        ),
      ),
        ListTile(
          title: Text('Rezerwacje'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pushNamed(context, '/court_card');
          },
        ),
        ListTile(
        title: Text('Ustawienia'),
    onTap: () {
    Navigator.pushNamed(context, '/reservations');},
    ),],),
    ),);
  }

}