import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './secondPage.dart'; 
import 'package:dropdown_formfield/dropdown_formfield.dart';

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
  bool reqFilter;
  String mop;
  String loc;
  String dropdownValue1='Location';
  String dropdownValue2='Mode of Payment';
  String _locFilter='', _mopFilter='';

  Widget _buildLocationDrop(){
    return Container(
                        padding: EdgeInsets.all(16),
                        child: DropDownFormField(
                          titleText: 'Location',
                          hintText: 
                            '-- Select --',
                          value: _locFilter,
                          onSaved: (value) {
                            setState(() {
                              _locFilter = value;
                            });
                            print(_locFilter);
                            print(_mopFilter);
                          },
                          onChanged: (value) {
                            setState(() {
                              _locFilter = value;
                            });
                            print(_locFilter);
                            print(_mopFilter);
                          },
                          dataSource: [
                            {
                              "display": "DLF",
                              "value": "DLF",
                            },
                            {
                              "display": "BBC",
                              "value": "BBC",
                            },
                            {
                              "display": "JC",
                              "value": "JC",
                            },
                            {
                              "display": "VC",
                              "value": "VC",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      );
  }

  Widget _buildPaymentDrop(){
    return Container(
                        padding: EdgeInsets.all(16),
                        child: DropDownFormField(
                          titleText: 'Mode of Payment',
                          hintText: '-- Select --',
                          value: _mopFilter,
                          onSaved: (value) {
                            setState(() {
                              _mopFilter = value;
                            });
                            print(_locFilter);
                            print(_mopFilter);
                          },
                          onChanged: (value) {
                            setState(() {
                              _mopFilter = value;
                            });
                            print(_locFilter);
                            print(_mopFilter);
                          },
                          dataSource: [
                            {
                              "display": "Cash",
                              "value": "CASH",
                            },
                            {
                              "display": "UPI(PayTM/GPay)",
                              "value": "UPI",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      );
  }

  Widget _buildClearButton(){
    return FloatingActionButton.extended(
                        onPressed: () { setState(() {
                          _locFilter='';
                          _mopFilter='';
                          print(_locFilter);
                          print(_mopFilter);
                        });}, 
                        label: Text('Clear'),
                        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Filter"),
                  content: Column(
                    children: <Widget>[
                      _buildLocationDrop(),
                      _buildPaymentDrop(),
                      _buildClearButton(),
                    ]),
                );
              });
        },
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("orders").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.documents
                          .where((DocumentSnapshot documentSnapshot) => (_mopFilter==''? true:documentSnapshot['mode_of_payment'].contains(_mopFilter)) && (_locFilter==''? true:documentSnapshot['place'].contains(_locFilter))).toList().length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> orderList = snapshots.data.documents
                          .where((DocumentSnapshot documentSnapshot) => (_mopFilter==''? true:documentSnapshot['mode_of_payment'].contains(_mopFilter)) && (_locFilter==''? true:documentSnapshot['place'].contains(_locFilter))).toList();
                    DocumentSnapshot documentSnapshot =
                        orderList.elementAt(index);
                    return Card(
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
                                  print(documentSnapshot.documentID);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondPage(
                                        title: documentSnapshot['address'], description: documentSnapshot['mode_of_payment'], description2: documentSnapshot['items'], orderID:documentSnapshot.documentID, from:documentSnapshot['place'], )));
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
