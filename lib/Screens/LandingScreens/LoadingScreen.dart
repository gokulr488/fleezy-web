import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/LoadingDots.dart';
import 'package:fleezy_web/Screens/HomePage/HomeScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/ErrorScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginScreen.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'LoadingScreen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _initialized = false;
  bool _error = false;
  bool _isLoggedIn = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
      _initialized = true;
    } catch (e) {
      _error = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    initializeFlutterFire();
    checkLoggedInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return HomeScreen();
    }
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

  void checkLoggedInStatus() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      //Provider.of<UiState>(context, listen: false).setIsAdmin(true);
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    setState(() {});
  }
}
