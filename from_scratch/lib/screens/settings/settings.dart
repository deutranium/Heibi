import 'package:flutter/material.dart';
import 'package:from_scratch/models/option.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Option> options = [
    Option('DLF', 'f0'),
    Option('J.C.', 'f1'),
    Option('Washing Machine', 'f2'),
    Option('Bakul Warehouse', 'f3'),
    Option('NBH Table Tennis', 'f4'),
  ];

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    print('yeet');
                  },
                ),
              ],
            ),
            Column(
                children: options.map((item) => optionTemplate(item)).toList()),
            Spacer(),
            Text(
              "More Settings",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            RaisedButton(
              color: Colors.pinkAccent[400],
              child: Text(
                'Reorder Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                print('Button 1');
              },
            ),
            RaisedButton(
              color: Colors.deepPurpleAccent[400],
              child: Text(
                'Modify User Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                print('Button 2');
              },
            ),
          ],
        ),
      ),
    );
  }
}
