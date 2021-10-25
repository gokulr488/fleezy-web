import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/LoadingDots.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const String id = 'LoadingScreen';

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
        child: Center(child: LoadingDots(size: 75)),
        headerText: 'Loading Fleezy. Please Wait');
  }
}
