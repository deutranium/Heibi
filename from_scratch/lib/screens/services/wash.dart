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
          var time = new DateTime.now();
          var startTimeA = snapshot.data.documents[widget.number]['A'].toDate();
          var startTimeB = snapshot.data.documents[widget.number]['B'].toDate();
          var startTimeC = snapshot.data.documents[widget.number]['C'].toDate();
          var diffA = time.difference(startTimeA).inMinutes;
          var diffB = time.difference(startTimeB).inMinutes;
          var diffC = time.difference(startTimeC).inMinutes;
          if (diffA < 41)
            diffA = 40 - diffA;
          else
            diffA = 0;
          if (diffB < 41)
            diffB = 40 - diffB;
          else
            diffB = 0;
          if (diffC < 41)
            diffC = 40 - diffC;
          else
            diffC = 0;

          return Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Minutes till machine is available: ',
                    style: TextStyle(fontSize: 23),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'A:',
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            // snapshot.data.documents[widget.number]['num']
                            //     .toString(),
                            diffA.toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          FloatingActionButton(
                            heroTag: "btn1",
                            backgroundColor: Colors.teal[400],
                            onPressed: () {
                              print('pushed');
                              var time = new DateTime.now();
                              var startTimeStamp =
                                  snapshot.data.documents[widget.number]['A'];
                              var startTime = startTimeStamp.toDate();
                              // print( time.difference(startTime).inSeconds );

                              snapshot.data.documents[0].reference.updateData({
                                'A': time,
                              });
                            },
                            tooltip: 'Increment',
                            child: Icon(Icons.cached),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'B:',
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                                diffB.toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          FloatingActionButton(
                            heroTag: "btn1",
                            backgroundColor: Colors.teal[400],
                            onPressed: () {
                              print('pushed');
                              var time = new DateTime.now();
                              print(time);
                              snapshot.data.documents[0].reference.updateData({
                                'B': time,
                              });
                            },
                            tooltip: 'Increment',
                            child: Icon(Icons.cached),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'C:',
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                                diffC.toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          FloatingActionButton(
                            heroTag: "btn1",
                            backgroundColor: Colors.teal[400],
                            onPressed: () {
                              print('pushed');
                              var time = new DateTime.now();
                              print(time);
                              snapshot.data.documents[0].reference.updateData({
                                'C': time,
                              });
                            },
                            tooltip: 'Increment',
                            child: Icon(Icons.cached),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ],
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
