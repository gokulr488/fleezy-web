import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(
      {this.bottomNavBar, required this.headerText, required this.child});
  final Widget child;
  final Widget? bottomNavBar;
  final String headerText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerText.isEmpty
          ? null
          : AppBar(
              toolbarHeight: 45,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(headerText,
                        style: GoogleFonts.laila(
                          color: kTextColor,
                          fontSize: 20,
                        )),
                    Text('Fleezy',
                        style: GoogleFonts.dancingScript(
                            color: kHighlightColour,
                            shadows: shadow,
                            fontWeight: FontWeight.bold,
                            fontSize: 35))
                  ]),
            ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
