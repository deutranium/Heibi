import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:from_scratch/models/user.dart';
import 'package:from_scratch/services/authenticate.dart';


class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final Authservice _auth = Authservice();



  String _items;
  String _address;
  String _payment;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildItems(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Items"),
      validator: (String value){
        if(value.isEmpty){
          return 'Items are required';
        }
      },
      onSaved: (String value){
        _items = value;
      },
    );
  }
  Widget _buildAddress(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Address"),
      validator: (String value){
        if(value.isEmpty){
          return 'Address is required';
        }
      },
      onSaved: (String value){
        _address = value;
      },
    );
  }
  Widget _buildPayment(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Mode Of payment"),
      validator: (String value){
        if(value.isEmpty){
          return 'You are going to pay in some way right?';
        }
      },
      onSaved: (String value){
        _payment = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Form")),
      body: Container(
        margin: EdgeInsets.all(24),
        child:Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildItems(),
              _buildAddress(),
              _buildPayment(),
              SizedBox(height:100),
              RaisedButton(
                child:Text('Order!', style:TextStyle(color: Colors.blue, fontSize: 16,)),
                onPressed : () async {
                  if(!_formKey.currentState.validate()){
                    return;
                  }
                  _formKey.currentState.save();
                  final user = await _auth.getUser();

                  Firestore.instance.collection('orders').document().setData({'items':_items, 'address':_address, 'mode_of_payment': _payment, 'User_id' : user.uid});

                }
              )
            ],
          ),
        ),
      )
    );
  }
}

