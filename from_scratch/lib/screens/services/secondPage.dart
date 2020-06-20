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
                Text(description),
                Text(description2),
                RaisedButton(
                    child: Text('Accept Order'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () => print("Accepted"),)
              ]),
        ));
  }
}