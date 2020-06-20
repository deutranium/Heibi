import 'package:flutter/material.dart';
// import 'package:from_scratch/screens/services/washingMachine.dart';
import 'package:from_scratch/services/authenticate.dart';
import 'package:from_scratch/shared/dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:from_scratch/shared/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authservice _auth = Authservice();

  bool loading = true;
  List<String> favs = [];

  Widget favCard(text) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      color: Colors.deepPurple[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getFavsList();
    return loading
        ? Loading()
        : Scaffold(
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
                      label: Text('logout'))
                ]),
            drawer: MainDrawer(),
            body: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: favs.map((text) => favCard(text)).toList())),
          );
  }

  Future _getFavsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('favlist') == false) {
      favs = [];
    } else {
      favs = prefs.getStringList('favlist');
    }
    setState(() {
      loading = false;
    });
  }
}
