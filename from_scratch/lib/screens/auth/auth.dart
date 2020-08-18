import 'package:flutter/material.dart';
import 'package:from_scratch/screens/auth/register.dart';

import 'package:from_scratch/screens/auth/signin.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = false;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      return SignIn(toggleView : toggleView);
    else
      return Register(toggleView : toggleView);
  }
}
