import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rezerwacja kortów',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Login Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(
    color: Colors.grey,
  );
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style:style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0 ),
        hintText: "E-mail",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextField(
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0 ),
        hintText: "Hasło",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color:Color(0xfff50057),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
          onPressed: (){},
          child: Text("Login", textAlign: TextAlign.center),
        )
    );
    final registerButton = Material(
      child:SignInButtonBuilder(
        text: 'Załóż konto',
        icon: Icons.email,
        onPressed: () {},
        backgroundColor: Colors.blueGrey[700],
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)
        ),
      ),
    );
    final fb_button = Material(
      child:SignInButton(
        Buttons.Facebook,
        text: "Konto Facebook",
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)
          //side: BorderSide(color: Colors.black)
        ),
        onPressed: () {},
      ),);
    final google_button = SignInButton(
      Buttons.Google,
      text: "Konto Google",
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      onPressed: () {},
    );


    return Scaffold(
        body: Center(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 220,
                        child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain),
                      ),
                      SizedBox(
                        height: 60.0,
                        child: emailField,
                      ),
                      SizedBox(
                        height: 70.0,
                        child: password,
                      ),
                      loginButton,
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(children: [registerButton, google_button, fb_button ],mainAxisAlignment: MainAxisAlignment.center,),
                    ],
                  ),
                )

            )
        )
    );
  }
}