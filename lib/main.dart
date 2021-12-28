import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/UiState.dart';
import 'package:fleezy_web/Screens/HomePage/HomeScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/ErrorScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoadingScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginScreen.dart';
import 'package:fleezy_web/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFlutterFire();
  runApp(MultiProvider(
    // ignore: always_specify_types
    providers: [
      ChangeNotifierProvider<AppData>(create: (_) => AppData()),
      ChangeNotifierProvider<UiState>(create: (_) => UiState()),
    ],
    child: FleezyWebApp(),
  ));
}

const bool _isEmulator = false;
FirebaseApp? firebase;

Future<void> initializeFlutterFire() async {
  try {
    firebase = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
      //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

class FleezyWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fleezy',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            primarySwatch: Colors.lime,
            //brightness: Brightness.dark,
            textTheme: GoogleFonts.koHoTextTheme(
                ThemeData(brightness: Brightness.light).textTheme)),
        debugShowCheckedModeBanner: false,
        initialRoute: LoadingScreen.id,
        routes: <String, Widget Function(BuildContext)>{
          LoginScreen.id: (BuildContext context) => LoginScreen(),
          LoadingScreen.id: (BuildContext context) => LoadingScreen(),
          ErrorScreen.id: (BuildContext context) => const ErrorScreen(),
          HomeScreen.id: (BuildContext context) => HomeScreen(),
        });
  }
}
