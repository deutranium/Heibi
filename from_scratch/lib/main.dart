import 'package:flutter/material.dart';
import 'package:from_scratch/models/user.dart';
import 'package:from_scratch/screens/wrapper.dart';
import 'package:from_scratch/services/authenticate.dart';
import 'package:provider/provider.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Authservice().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
