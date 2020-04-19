import 'package:flutter/material.dart';
import 'package:rezerwacjakortow/screens/auth.dart';
import 'package:rezerwacjakortow/screens/auth_provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'To pole nie może być puste' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'To pole nie może być puste' : null;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String userId = await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          final String userId = await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Rezerwacja kortów'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[
              SizedBox(
                height: 220,
                child: Image.asset( //logo
                    "assets/images/logo.png",
                    fit: BoxFit.contain),
              ),
              SizedBox(
                height: 10.0,
              ),
            ]+buildInputs()+buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      TextFormField(
        key: Key('email'),
        obscureText: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0 ),
          hintText: "E-mail",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        validator: EmailFieldValidator.validate,
        onSaved: (String value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0 ),
          hintText: "Hasło",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (String value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
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
    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color:Color(0xfff50057),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 15.0),
          onPressed: validateAndSubmit,
          child: Text("Login", textAlign: TextAlign.center),
        )
    );
    final registerButton = Material(
      child:SignInButtonBuilder(
        text: 'Załóż konto',
        icon: Icons.email,
        onPressed: moveToRegister,
        backgroundColor: Colors.blueGrey[700],
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)
        ),
      ),
    );
    if (_formType == FormType.login) {
      return <Widget>[
        loginButton,
        Column(children: [registerButton, google_button, fb_button ],mainAxisAlignment: MainAxisAlignment.center,),

      ];
    } else {
      return <Widget>[
        RaisedButton(
          child: Text('Utwórz Konto', style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)
          ),
          onPressed: validateAndSubmit,
        ),
        RaisedButton(
          child: Text('Przejdź do logowania', style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)
          ),
          color:Color(0xfff50057),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}