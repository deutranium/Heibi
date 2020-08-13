import 'package:from_scratch/screens/services/displayOrders.dart';
import 'package:from_scratch/screens/services/orderForm.dart';
import 'package:from_scratch/screens/services/sport.dart';
import 'package:from_scratch/screens/services/wash.dart';
import 'package:from_scratch/screens/services/profile.dart';
import 'package:from_scratch/screens/settings/settings.dart';


class Option {
  String name;
  String key;
  bool state;

  Option(String name, String key) {
    this.name = name;
    this.key = key;
  }
}

List<Option> options = [
  Option('DLF', 'f0'),
  Option('J.C.', 'f1'),
  Option('Washing Machine', 'f2'),
  Option('Bakul Warehouse', 'f3'),
  Option('NBH Table Tennis', 'f4'),
];
 var identifier = {
   'DLF': FormScreen(),
   'J.C.': FormScreen(),
   'Washing Machine' : new WashingMachine(number: 0, item: 'WashingMachines', maxNum: 3),
   'Bakul Warehouse' : sport(number: 0, item: 'Table Tennis', maxNum: 2),
   'NBH Table Tennis' : sport(number: 0, item: 'Table Tennis', maxNum: 2),
 };


class OptionDisplay {
  String name;
  dynamic link;
  OptionDisplay(String name){
    this.name = name;
  }
}