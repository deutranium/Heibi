import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WashingMachine extends StatefulWidget {
  WashingMachine({Key key, this.item, this.number, this.max_num})
      : super(key: key);
  final String item;
  final int number;
  final int max_num;
  @override
  _WashingMachineState createState() => _WashingMachineState();
}

class _WashingMachineState extends State<WashingMachine> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    'available machines:',
                  ),
                  Text(
                    snapshot.data.documents[widget.number]['num'].toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      int fin =
                          snapshot.data.documents[widget.number]['num'] + 1;
                      if (fin <= widget.max_num) {
                        snapshot.data.documents[0].reference.updateData({
                          'num': fin,
                        });
                      }
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
