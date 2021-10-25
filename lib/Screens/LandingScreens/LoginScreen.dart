import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/LoadingDots.dart';
import 'package:fleezy_web/Components/RoundedButton.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const TextStyle kMessagesTextStyle = TextStyle(fontSize: 15);

class _LoginScreenState extends State<LoginScreen> {
  LoginController ctrl = LoginController();
  String message = '';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      headerText: 'Welcome To Fleezy',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Fleezy',
              style: GoogleFonts.dancingScript(
                  color: kHighlightColour,
                  shadows: shadow,
                  fontWeight: FontWeight.bold,
                  fontSize: 60)),
          if (message == 'Logging In...') const LoadingDots(size: 50),
          Text(message, style: kMessagesTextStyle),
          SizedBox(
            width: 300,
            child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (String value) {
                  ctrl.phoneNo = '+91$value'; //TODO change this impl
                },
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Phone Number')),
          ),
          Visibility(
              visible: ctrl.verified,
              child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    ctrl.otp = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Enter the OTP'))),
          RoundedButton(
            title: ctrl.verified ? 'Log In' : 'Send OTP',
            width: 300,
            onPressed: () async {
              await ctrl.onButtonPressed(context);
            },
          ),
        ],
      ),
    );
  }
}
