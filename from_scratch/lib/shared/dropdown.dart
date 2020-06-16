import 'package:flutter/material.dart';
import 'package:from_scratch/screens/services/orderForm.dart';
import 'package:from_scratch/screens/services/wash.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.pink[200],
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Text(
                'washing machine',
                style: TextStyle(fontSize: 20),
                
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new WashingMachine(number: 0, item: 'WashingMachines', maxNum : 3 );
                }));
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Text(
                'form',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new FormScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
