import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDisplay extends StatefulWidget {
  @override
  _OrderDisplayState createState() => _OrderDisplayState();
}

class OrderDisplay extends State<OrderDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(widget.item),
    ),

}