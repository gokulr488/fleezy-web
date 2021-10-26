import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoadingScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FleezyWebApp());
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
        });
  }
}
