import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
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