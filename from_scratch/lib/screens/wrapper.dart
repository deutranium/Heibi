import 'package:flutter/material.dart';
import 'package:from_scratch/models/user.dart';
import 'package:from_scratch/screens/auth/auth.dart';
import 'package:from_scratch/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    
    if (user == null) {
      return Auth();
    } else {
      return Home();
    }
  }
}
