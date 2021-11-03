import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/cards/VehicleCard.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';

class AddFuelController {
  final TextEditingController totalAmntCtrl = TextEditingController();
  final TextEditingController fuelRateCtrl = TextEditingController();
  final TextEditingController litresFilledCtrl = TextEditingController();
  final TextEditingController odoReadingCtrl = TextEditingController();
  DateTime tripStartDate = DateTime.now();

  void onAddFuel(BuildContext context) {}

  VehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        vehicle: vehicle,
        color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
        message: vehicle.getWarningMessage());
  }
}
