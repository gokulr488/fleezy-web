import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/cards/VehicleCard.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';

class AddTripController {
  final TextEditingController startingFromCtrl =
      TextEditingController(text: 'Vallarpadam');
  final TextEditingController destinationCtrl =
      TextEditingController(text: 'Maruthoorkadavu');
  final TextEditingController startOdoCtrl = TextEditingController(text: '0');
  final TextEditingController endOdoCtrl = TextEditingController(text: '0');
  final TextEditingController customerNameCtrl =
      TextEditingController(text: 'Amritha Agencies');
  final TextEditingController customerPhoneCtrl = TextEditingController();
  final TextEditingController totalAmntCtrl = TextEditingController();
  final TextEditingController paidAmntCtrl = TextEditingController();
  final TextEditingController driverSalCtrl = TextEditingController();
  DateTime tripStartDate = DateTime.now();

  void onSaveTrip(BuildContext context) {}

  VehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        vehicle: vehicle,
        color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
        message: vehicle.getWarningMessage());
  }
}
