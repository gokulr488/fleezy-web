import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoadingScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginScreen.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FleezyWebApp());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [FleezyWebApp] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class FleezyWebApp extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _FleezyWebAppState createState() => _FleezyWebAppState();
}

class _FleezyWebAppState extends State<FleezyWebApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return _getFlutterApp(LoadingScreen.id);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          debugPrint('Initialised Firebase');
          return _getFlutterApp(LoginScreen.id);
        }
        return _getFlutterApp(LoadingScreen.id);
      },
    );
  }

  MaterialApp _getFlutterApp(String initialRoute) {
    return MaterialApp(
        title: 'Fleezy',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            primarySwatch: Colors.lime,
            //brightness: Brightness.dark,
            textTheme: GoogleFonts.koHoTextTheme(
                ThemeData(brightness: Brightness.light).textTheme)),
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: <String, Widget Function(BuildContext)>{
          LoginScreen.id: (BuildContext context) => LoginScreen(),
          LoadingScreen.id: (BuildContext context) => LoadingScreen(),
        });
  }
}
