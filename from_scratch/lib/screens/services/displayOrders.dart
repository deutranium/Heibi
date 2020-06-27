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
  String locFilter='', mopFilter='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Les Orders"),
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
                      Container(
                        padding: EdgeInsets.all(16),
                        child: DropDownFormField(
                          titleText: 'Location',
                          hintText: '-- Select --',
                          value: locFilter,
                          onSaved: (value) {
                            setState(() {
                              locFilter = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              locFilter = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "DLF",
                              "value": "dlf",
                            },
                            {
                              "display": "BBC",
                              "value": "bbc",
                            },
                            {
                              "display": "JC",
                              "value": "jc",
                            },
                            {
                              "display": "VC",
                              "value": "vc",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: DropDownFormField(
                          titleText: 'Mode of Payment',
                          hintText: '-- Select --',
                          value: mopFilter,
                          onSaved: (value) {
                            setState(() {
                              mopFilter = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              mopFilter = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "Cash",
                              "value": "cash",
                            },
                            {
                              "display": "UPI(PayTM/GPay)",
                              "value": "upi",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                      FloatingActionButton.extended(
                        onPressed: () { setState(() {
                          locFilter='';
                          mopFilter='';
                        });}, 
                        label: Text('Clear'),
                        ),
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
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> orderList = snapshots.data.documents
                          .where((DocumentSnapshot documentSnapshot) => documentSnapshot['mode_of_payment'].toLowerCase().contains(mopFilter.toLowerCase()) && documentSnapshot['place'].toLowerCase().contains(locFilter.toLowerCase()).toList());
                    DocumentSnapshot documentSnapshot =
                        orderList.toList()[index];
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
