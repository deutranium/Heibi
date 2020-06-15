import 'package:flutter/material.dart';
import 'package:from_scratch/services/authenticate.dart';
import 'package:from_scratch/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final Authservice _auth = Authservice();

  String email = '';
  String passwd = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Text('Register'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('login'),
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
                      decoration: InputDecoration(
                        hintText: 'Email'
                      ),
                      validator: (val) => val.isEmpty ? 'enter email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'password'
                      ),
                      validator: (val) => val.length < 6 ? 'enter valid password(6+ chars)' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => passwd = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.orange[100],
                      child: Text('register'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.regWithEmail(email, passwd);
                          if (result == null){
                            loading = false;
                            setState( () => error = 'please give valid email & password');
                         }print(email);
                          print(passwd);
                        }
                      },
                    ),
                    Text(error)
                  ],
                ))));
  }
}
