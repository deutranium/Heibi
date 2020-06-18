import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  Widget _buildItems() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Items"),
      validator: (val) => val.isEmpty ? 'enter Items' : null,
      onSaved: (String value) {
        _items = value;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Address"),
      validator: (val) => val.isEmpty ? 'enter Address' : null,
      onSaved: (String value) {
        _address = value;
      },
    );
  }

  Widget _buildPayment() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Mode Of payment"),
      validator: (val) => val.isEmpty ? 'enter mode of payment' : null,
      onSaved: (String value) {
        _payment = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[100],
        appBar: AppBar(
          title: Text("Form"),
          backgroundColor: Colors.deepOrange[400],
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildItems(),
                _buildAddress(),
                _buildPayment(),
                SizedBox(height: 90),
                RaisedButton(
                    color: Colors.deepOrange[400],
                    child: Text('Order!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                    onPressed: () async {
                      print("hey!");
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      final user = await _auth.getUser();

                      Firestore.instance
                          .collection('orders')
                          .document()
                          .setData({
                        'items': _items,
                        'address': _address,
                        'mode_of_payment': _payment,
                        'User_id': user.uid
                      });
                      _formKey.currentState.reset();   //to reset the form after each submission
                    //   alert to tell the user the order has been placed
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("Your Order has been Placed"),
                            );
                        }
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
