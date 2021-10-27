import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(headerText: 'Welcome', child: Text('Home Page'));
  }
}
