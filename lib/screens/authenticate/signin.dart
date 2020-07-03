import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //Text field state
  String email = "";
  String password = "";
  var error;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text("SignIn"),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                )
              ],
              elevation: 0.0,
              backgroundColor: Colors.brown[400],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 28.0,
                    ),
                    TextFormField(
                      decoration:
                          TextInputDeccoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          TextInputDeccoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6 chars long'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text("SignIn"),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = "Couldn't Sign in";
                            });
                            print(error);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
//nonymous signin
//RaisedButton(
//          onPressed: () async{
//            dynamic result = await _auth.signInAnon();
//            if(result == null){
//              print('Error');
//            }else{
//              print('done');
//              print(result.uid);
//            }
//          },
//          child: Text('Sign in anon'),
//        ),
