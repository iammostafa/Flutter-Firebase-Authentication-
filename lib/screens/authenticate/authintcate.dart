import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/authenticate/register.dart';
import 'package:flutter_firebase/screens/authenticate/signin.dart';

class Authnticate extends StatefulWidget {
  Authnticate({Key key}) : super(key: key);

  @override
  _AuthnticateState createState() => _AuthnticateState();
}

class _AuthnticateState extends State<Authnticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
