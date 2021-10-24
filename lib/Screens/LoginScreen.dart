import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
        child: Text('Success'), headerText: 'Welcome To Fleezy');
  }
}
