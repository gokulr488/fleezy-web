import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/Responsive.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        headerText: 'Welcome',
        drawer: Responsive.isMobile(context)
            ? const Drawer(child: _DrawerElements())
            : null,
        child: Responsive(
            mobile: const Text('Mobile view'),
            desktop: Row(
              children: const <Widget>[_DrawerElements()],
            )));
  }
}

class _DrawerElements extends StatelessWidget {
  const _DrawerElements();
  final TextStyle drawerTS = const TextStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? 250 : null,
      color: kActiveCardColor,
      child: ListView(
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.account_balance_outlined),
              title: Text('Companies', style: drawerTS)),
          ListTile(
              leading: const Icon(Icons.car_repair),
              title: Text('Vehicles', style: drawerTS)),
          ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text('Drivers', style: drawerTS)),
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
