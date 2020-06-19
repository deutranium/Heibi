import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './secondPage.dart'; 

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.orange),
      home: DisplayOrders(),
    ));

class DisplayOrders extends StatefulWidget {
  @override
  _DisplayOrdersState createState() => _DisplayOrdersState();
}

class _DisplayOrdersState extends State<DisplayOrders> {
  String _items;
  String _address;
  String _payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Les Orders"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(8)),
      //             title: Text("Add Shiz"),
      //             content: TextField(
      //               onChanged: (String value) {
      //                 todoTitle = value;
      //               },
      //             ),
      //             actions: <Widget>[
      //               FlatButton(
      //                   onPressed: () {
      //                     createTodos();

      //                     Navigator.of(context).pop();
      //                   },
      //                   child: Text("Add"))
      //             ],
      //           );
      //         });
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("orders").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data.documents[index];
                    return Dismissible(
                        key: Key(documentSnapshot["address"]),
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: Text(documentSnapshot['address']),
                            trailing: FlatButton(
                                child: Text("See more"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondPage(
                                        title: documentSnapshot['address'], description: documentSnapshot['mode_of_payment'], description2: documentSnapshot['items'])));
                                }),
                          ),
                        ));
                  });
            } else {
              return Align(
                alignment: FractionalOffset.bottomCenter,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}





/*import 'package:flutter/material.dart';

class DisplayOrders extends StatefulWidget {
  @override
  _DisplayOrdersState createState() => _DisplayOrdersState();
}

class _DisplayOrdersState extends State<DisplayOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        ),
      
    );
  }
}*/
