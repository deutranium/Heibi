import 'package:flutter/material.dart';
import 'package:from_scratch/screens/services/displayOrders.dart';
import 'package:from_scratch/screens/services/orderForm.dart';
import 'package:from_scratch/screens/services/wash.dart';
import 'package:from_scratch/screens/services/profile.dart';
import 'package:from_scratch/screens/settings/settings.dart';

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
                  return new WashingMachine(
                      number: 0, item: 'WashingMachines', maxNum: 3);
                }));
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Text(
                'Place Order',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new FormScreen();
                }));
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new Profile();
                }));
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Text(
                'Display Orders',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new DisplayOrders();
                }));
              },
            ),
            Spacer(),
            ListTile(
              contentPadding: EdgeInsets.all(20.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Settings', style: TextStyle(fontSize: 20)),
                  Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new SettingsScreen();
>>>>>>> from_scratch/lib/shared/dropdown.dart
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
