import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:from_scratch/services/authenticate.dart';

class SecondPage extends StatefulWidget {
  SecondPage({@required this.title, this.description, this.description2, this.orderID, this.from});

  String title;
  String description;
  String description2;
  String orderID;
  String from;
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final Authservice _auth = Authservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Mode of Payment: '+widget.description, style: TextStyle(color: Colors.black, fontSize: 20),),
                SizedBox(height:30),
                Text('Items: '+widget.description2, style: TextStyle(color: Colors.black, fontSize: 20),),
                SizedBox(height:30),
                RaisedButton(
                    child: Text('Accept Order', style: TextStyle(color: Colors.white, fontSize: 20),),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      // do make accepted for the order true, then add it to accepted orders, and then add to chats
                      print("startes");
                      final accepted = await _auth.getUser();
                      final ordered = await Firestore.instance.collection("orders").document(widget.orderID).get().then((value){
                        return value.data["User_id"];
                      });
                      final message = "Hi! I would like "+ widget.description2 + " from "+ widget.from + ". Thanks for accepting my order!!";
                      var now = new DateTime.now();
                      print("part1");
                      Firestore.instance.collection("orders").document(widget.orderID).updateData({
                          "accepted" : true,
                      });
                      print("part2");
                      Firestore.instance.collection("accepted_orders").document().setData({
                        "accepted" : accepted.uid,
                        "ordered" : ordered,
                        "chat_id" : widget.orderID,
                      });
                      print("part3");
                      Firestore.instance.collection("chats").document(widget.orderID).setData({
                        "order_id" : widget.orderID,
                      });
                      print("part4");
                      Firestore.instance.collection("chats").document(widget.orderID).collection("messages").document().setData({
                        "message" : message,
                        "time" : now,
                        "user" : ordered,
                      });
                      print("part5");
                    },
                )
              ]),
        ));
  }
}


