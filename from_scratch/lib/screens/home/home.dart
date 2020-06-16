import 'package:flutter/material.dart';
// import 'package:from_scratch/screens/services/washingMachine.dart';
import 'package:from_scratch/services/authenticate.dart';
import 'package:from_scratch/shared/dropdown.dart';

class Home extends StatelessWidget {

  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(

        title: Text("Home"),
        backgroundColor: Colors.deepPurple[400],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              await _auth.signout();
            },
            label: Text('logout')
          )
        ]
      ),
      drawer: MainDrawer(

      ),
      body: Container(

      )
    );
  }
}
