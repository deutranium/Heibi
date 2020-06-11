import 'package:flutter/material.dart';

import '../screens/test.dart';
import '../screens/HomeScreen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Text('okay', style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder : (context) => Test())
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Text('main', style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder : (context) { return new MyHomePage(title : 'Flutter Demo Home Page'); })
                );
              },
            ),
          ],
        ),
    );
  }
}