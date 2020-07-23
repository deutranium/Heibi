import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:from_scratch/screens/services/chatScreen.dart';
import './secondPage.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      accentColor: Colors.orange),
  home: DisplayAccepted(),
));

class DisplayAccepted extends StatefulWidget {
  DisplayAccepted({Key key, this.type, this.uid})
      : super(key: key);
  final String type;
  final String uid;
  // widget.type should give 'accepted' or 'ordered' depending on whether we want chats where the person ordered stuff or accepted orders
  @override
  _DisplayAcceptedState createState() => _DisplayAcceptedState();
}

class _DisplayAcceptedState extends State<DisplayAccepted> {
  String _items;
  String _address;
  String _payment;
  bool reqFilter;
  String mop;
  String loc;
  String dropdownValue1='Location';
  String dropdownValue2='Mode of Payment';
  String _locFilter='', _mopFilter='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),

      body: StreamBuilder(
          stream: Firestore.instance.collection("accepted_orders").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.documents
                      .where((DocumentSnapshot documentSnapshot) => (documentSnapshot[widget.type]==widget.uid ? true : false)).toList().length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> orderList = snapshots.data.documents
                        .where((DocumentSnapshot documentSnapshot) => (documentSnapshot[widget.type]==widget.uid ? true : false )).toList();
                    DocumentSnapshot documentSnapshot =
                    orderList.elementAt(index);
                    return Card(
                        key: Key("bruh"),
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: Text("bruh"),
                            trailing: FlatButton(
                                child: Text("go to chat"),
                                onPressed: () {
                                  print("okay");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => chatScreen(chat_id : documentSnapshot["chat_id"] , user_id : widget.uid)));
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