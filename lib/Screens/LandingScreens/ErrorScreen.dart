import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen();

  static const String id = 'ErrorScreen';
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
        headerText: 'Error',
        child: Center(child: Text('Error loading FleeZy')));
  }
}
