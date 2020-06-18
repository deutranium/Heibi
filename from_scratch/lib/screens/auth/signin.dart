import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter/material.dart';
import 'package:from_scratch/services/authenticate.dart';
import 'package:from_scratch/shared/loading.dart';

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
  String email = '';
  String passwd = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    print("hi");
    print(loading);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.deepOrange[100],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange[400],
              title: Text('Login'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'enter email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'password'),
                          validator: (val) => val.length < 6
                              ? 'enter valid password(6+ chars)'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => passwd = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Colors.lightGreen[100],
                          child: Text('sign in'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print('valid');
                              loading = true;
                              setState(() => loading = true);
                              print(loading);
                              dynamic result =
                                  await _auth.signInWithEmail(email, passwd);
                              print(result);
                              print('heyo');
                              if (result == null) {
                                loading = false;
                                setState(() => error =
                                    'please give valid email & password');
                              }
                              // print(email);
                              // print(passwd);
                            }
                          },
                        ),
                        SignInButton(
                          Buttons.GoogleDark,
                          // backgroundColor: Colors.deepOrange,
                          onPressed: () async {
                            dynamic result = _auth.signInWithGoogle();
                            print(result);
                          },
                          // child: Text('G'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red[800]),
                        ),
                      ],
                    ))));
  }
}
