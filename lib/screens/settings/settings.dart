import 'package:flutter/material.dart';
import 'package:from_scratch/models/option.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:from_scratch/shared/loading.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = true;

  Widget optionTemplate(item) {
    return CheckboxListTile(
        title: Text(item.name, style: TextStyle(fontSize: 20)),
        value: item.state,
        onChanged: (bool value) {
          setState(() {
            item.state = value;
            print(value);
          });
        });
  }

  @override
  void initState() {
    _getFavs();
    print("yeetn't");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueGrey[100],
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[400],
              title: Text('Personalise'),
            ),
            body: Container(
              margin: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Favourites",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                        color: Colors.blueGrey[400],
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          _saveFavs();
                          print('yeet');
                        },
                      ),
                    ],
                  ),
                  Column(
                      children:
                          options.map((item) => optionTemplate(item)).toList()),
                  // Spacer(),
                  // Text(
                  //   "More Settings",
                  //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  // ),
                  // RaisedButton(
                  //   color: Colors.pinkAccent[400],
                  //   child: Text(
                  //     'Reorder Navigation',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     print('Button 1');
                  //   },
                  // ),
                  // RaisedButton(
                  //   color: Colors.deepPurpleAccent[400],
                  //   child: Text(
                  //     'Modify User Details',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     print('Button 2');
                  //   },
                  // ),
                ],
              ),
            ),
          );
  }

  Future _getFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Option item in options) {
      bool value = prefs.getBool(item.key);
      if (value == true) {
        item.state = true;
      } else {
        item.state = false;
      }
    }
    setState(() {
      loading = false;
    });
  }

  void _saveFavs() async {
    List<String> myList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Option item in options) {
      prefs.setBool(item.key, item.state);
      if (item.state) {
        myList.add(item.name);
      }
    }
    prefs.setStringList('favlist', myList);
  }
}
