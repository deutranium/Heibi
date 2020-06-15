import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection refference
  final CollectionReference washingMachine =
      Firestore.instance.collection('washingMachines');
}
