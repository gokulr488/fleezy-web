import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/UiState.dart';
import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/Responsive.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';
import 'package:fleezy_web/Screens/DriverManagementScreens/DriverManagementScreen.dart';
import 'package:fleezy_web/Screens/VehicleManagementScreens/VehiclesScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany;
    return BaseScreen(
        headerText: 'Welcome to ${company.companyName}',
        drawer: Responsive.isMobile(context)
            ? const Drawer(child: _DrawerElements())
            : null,
        child: Responsive(
            mobile: Consumer<UiState>(
                builder: (BuildContext context, UiState uiState, _) {
              return uiState.centerWidget;
            }),
            desktop: Row(
              children: <Widget>[
                const _DrawerElements(),
                Consumer<UiState>(
                    builder: (BuildContext context, UiState uiState, _) {
                  return uiState.centerWidget;
                })
              ],
            )));
  }
}

class _DrawerElements extends StatelessWidget {
  const _DrawerElements();
  final TextStyle drawerTS = const TextStyle();

  @override
  Widget build(BuildContext context) {
    UiState uiState = Provider.of<UiState>(context, listen: false);
    return Container(
      width: Responsive.isDesktop(context) ? 250 : null,
      color: kActiveCardColor,
      child: ListView(
        children: <Widget>[
          if (Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Fleezy',
                  style: GoogleFonts.dancingScript(
                      color: kHighlightColour,
                      shadows: shadow,
                      fontWeight: FontWeight.bold,
                      fontSize: 35)),
            ),
          ListTile(
              leading: const Icon(Icons.account_balance_outlined),
              title: Text('Companies', style: drawerTS)),
          ListTile(
              leading: const Icon(Icons.car_repair),
              title: Text('Vehicles', style: drawerTS),
              onTap: () {
                if (Responsive.isMobile(context)) Navigator.of(context).pop();
                uiState.setCenterWidget(const VehiclesScreen());
              }),
          ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text('Drivers', style: drawerTS),
              onTap: () {
                if (Responsive.isMobile(context)) Navigator.of(context).pop();
                uiState.setCenterWidget(const DriverManagementScreen());
              }),
          ListTile(
              leading: const Icon(Icons.attach_money),
              title: Text('Pending Balances', style: drawerTS)),
          ListTile(
              leading: const Icon(Icons.receipt_long_rounded),
              title: Text('Reports', style: drawerTS)),
          ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text('Profile', style: drawerTS)),
        ],
      ),
    );
  }
}
