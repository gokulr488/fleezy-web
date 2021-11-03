import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/Authentication.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/UiState.dart';
import 'package:fleezy_web/Components/BaseScreen.dart';
import 'package:fleezy_web/Components/Responsive.dart';
import 'package:fleezy_web/DataAccess/DAOs/Company.dart';
import 'package:fleezy_web/DataAccess/DAOs/Roles.dart';
import 'package:fleezy_web/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/Screens/AddFuelScreen/AddFuelScreen.dart';
import 'package:fleezy_web/Screens/AddTripScreen/AddTripScreen.dart';
import 'package:fleezy_web/Screens/DriverManagementScreens/DriverManagementScreen.dart';
import 'package:fleezy_web/Screens/LandingScreens/LoadingScreen.dart';
import 'package:fleezy_web/Screens/VehicleManagementScreen/VehiclesScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ModelCompany? company =
        Provider.of<AppData>(context, listen: false).selectedCompany;
    return BaseScreen(
        headerText: 'Welcome to ${company?.companyName ?? 'FleeZy'}',
        drawer: !Responsive.isDesktop(context)
            ? const Drawer(child: _DrawerElements())
            : null,
        child: Responsive(
            mobile: Consumer<UiState>(
                builder: (BuildContext context, UiState uiState, _) {
              return uiState.centerWidget;
            }),
            desktop: Row(
              children: [
                const _DrawerElements(),
                Consumer<UiState>(
                    builder: (BuildContext context, UiState uiState, _) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 266,
                        child: uiState.centerWidget),
                  );
                })
              ],
            )));
  }

  Future<void> _getUserData() async {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.user == null) {
      debugPrint('Getting User basic Info.');
      User? authUser = Authentication().getUser();
      if (authUser == null) {
        _logoutUser(context);
        return;
      }
      final ModelUser? user = await Roles().getUser(authUser.phoneNumber);
      if (user?.state == Constants.INACTIVE) {
        _logoutUser(context);
        return;
      }
      appData.setUser(user);
    }
    if (appData.selectedCompany == null) {
      debugPrint('Getting Company Info.');
      CallContext callContext =
          await Company().getCompanyById(appData.user!.companyId.first);
      if (!callContext.isError) {
        Provider.of<AppData>(context, listen: false)
            .setSelectedCompany(callContext.data);
      }
      if (appData.user!.roleName != Constants.ADMIN) {
        Provider.of<UiState>(context, listen: false).setIsAdmin(isAdmin: false);
      }
    }
    if (appData.availableVehicles.isEmpty) {
      debugPrint('Getting Vehicle List.');
      Vehicle().getVehicleList(appData);
    }
    setState(() {});
  }

  void _logoutUser(BuildContext context) {
    Authentication().logout();
    Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
    Navigator.pushReplacementNamed(context, LoadingScreen.id);
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
        children: [
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
              leading: const Icon(Icons.add_road),
              title: Text('Add New Trip', style: drawerTS),
              onTap: () {
                if (Responsive.isMobile(context)) Navigator.of(context).pop();
                uiState.setCenterWidget(const AddTripScreen());
              }),
          ListTile(
              leading: const Icon(Icons.add_circle_rounded),
              title: Text('Add Fuel', style: drawerTS),
              onTap: () {
                if (Responsive.isMobile(context)) Navigator.of(context).pop();
                uiState.setCenterWidget(const AddFuelScreen());
              }),
          ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: Text('Add Expense', style: drawerTS),
              onTap: () {
                if (Responsive.isMobile(context)) Navigator.of(context).pop();
                uiState.setCenterWidget(const VehiclesScreen());
              }),
          ListTile(
              leading: const Icon(Icons.car_repair),
              title: Text('Manage Vehicles', style: drawerTS),
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
