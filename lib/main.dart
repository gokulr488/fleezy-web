import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Screens/HomePage/HomeScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/ErrorScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoadingScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    // ignore: always_specify_types
    providers: [
      ChangeNotifierProvider<AppData>(create: (_) => AppData()),
    ],
    child: FleezyWebApp(),
  ));
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
          ErrorScreen.id: (BuildContext context) => ErrorScreen(),
          HomeScreen.id: (BuildContext context) => HomeScreen(),
        });
  }
}
