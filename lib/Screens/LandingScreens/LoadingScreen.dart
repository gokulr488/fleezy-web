import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/LoadingDots.dart';
import 'package:fleezy_web/Screens/LandingScreens/ErrorScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginScreen.dart';
import 'package:fleezy_web/main.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'LoadingScreen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    checkFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return const ErrorScreen();
    }
    if (!_initialized) {
      return const BaseScreen(
          child: Center(child: LoadingDots(size: 75)),
          headerText: 'Loading Fleezy. Please Wait');
    }

    return LoginScreen();
  }

  void checkFirebase() async {
    try {
      if (firebase != null) {
        _initialized = true;
      }
    } catch (e) {
      _error = true;
    }
    setState(() {});
  }
}
