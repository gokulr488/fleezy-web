import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/LoadingDots.dart';
import 'package:fleezy_web/Components/Responsive.dart';
import 'package:fleezy_web/Components/RoundedButton.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextStyle kMessagesTextStyle = TextStyle(fontSize: 15);

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController ctrl = LoginController();
  String message = '';

  @override
  void initState() {
    super.initState();
    ctrl.initListener();
    ctrl.userSubscription = ctrl.userStream.listen(onUserStreamEvent);
    ctrl.messages.listen(onMessage);
  }

  @override
  void dispose() {
    super.dispose();
    ctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      headerText: 'Welcome To Fleezy',
      child: Responsive(
          mobile: Column(
            children: <Widget>[
              const _ImageWidget(),
              _LoginForm(message: message, ctrl: ctrl),
            ],
          ),
          desktop: Row(
            children: <Widget>[
              const _ImageWidget(),
              _LoginForm(message: message, ctrl: ctrl),
            ],
          )),
    );
  }

  Future<void> onUserStreamEvent(User? user) async {
    if (user == null) {
      debugPrint('Login Screen :User is currently signed out!');
    } else {
      if (ctrl.verified) {
        ctrl.verified = false; //to avoid multiple entry into this code
        ctrl.showSpinner = true;
        ctrl.disableButton = true;
        setState(() {});
        await ctrl.onVerificationCompleted(context);
        debugPrint('Login Screen :User signed in!');
      }
    }
  }

  void onMessage(String event) {
    message = event;
    setState(() {});
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.message,
    required this.ctrl,
  });

  final String message;
  final LoginController ctrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: Responsive.isDesktop(context) ? 1 : 3,
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
                onChanged: (String value) =>
                    ctrl.phoneNo = '+91$value' //TODO change this impl
                ,
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Phone Number')),
          ),
          SizedBox(
            width: 300,
            child: TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (String value) => ctrl.otp = value,
                decoration: kTextFieldDecoration.copyWith(labelText: 'OTP')),
          ),
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

class _ImageWidget extends StatelessWidget {
  const _ImageWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: Responsive.isDesktop(context) ? 3 : 1,
      child: Image.asset(
        'assets/images/startPageImage.jpg',
        colorBlendMode: BlendMode.darken,
      ),
    );
  }
}
