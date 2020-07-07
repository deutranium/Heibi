import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  SecondPage({@required this.title, this.description, this.description2});

  String title;
  String description;
  String description2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Mode of Payment: '+description, style: TextStyle(color: Colors.black, fontSize: 20),),
                SizedBox(height:30),
                Text('Items: '+description2, style: TextStyle(color: Colors.black, fontSize: 20),),
                SizedBox(height:30),
                RaisedButton(
                    child: Text('Accept Order', style: TextStyle(color: Colors.white, fontSize: 20),),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () => print("Accepted"),)
              ]),
        ));
  }
}