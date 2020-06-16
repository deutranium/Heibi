import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WashingMachine extends StatefulWidget {
  WashingMachine({Key key, this.item, this.number, this.maxNum})
      : super(key: key);
  final String item;
  final int number;
  // ignore: non_constant_identifier_names
  final int maxNum;
  @override
  _WashingMachineState createState() => _WashingMachineState();
}

class _WashingMachineState extends State<WashingMachine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(widget.item),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection(widget.item).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Available machines:',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    snapshot.data.documents[widget.number]['num'].toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.teal[400],
                    onPressed: () {
                      int fin =
                          snapshot.data.documents[widget.number]['num'] + 1;
                      if (fin <= widget.maxNum) {
                        snapshot.data.documents[0].reference.updateData({
                          'num': fin,
                        });
                      }
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Colors.teal[400],
                    onPressed: () {
                      int fin =
                          snapshot.data.documents[widget.number]['num'] - 1;
                      if (fin > -1) {
                        snapshot.data.documents[0].reference.updateData({
                          'num': fin,
                        });
                      }
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
