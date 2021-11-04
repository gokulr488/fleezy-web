import 'package:fleezy_web/Common/Alerts.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/Common/Validator.dart';
import 'package:fleezy_web/Components/cards/VehicleCard.dart';
import 'package:fleezy_web/DataAccess/TripApis.dart';
import 'package:fleezy_web/DataModels/ModelTrip.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';

class AddTripController {
  final TextEditingController startingFromCtrl =
      TextEditingController(text: 'Vallarpadam');
  final TextEditingController destinationCtrl =
      TextEditingController(text: 'Maruthoorkadavu');
  final TextEditingController startOdoCtrl = TextEditingController();
  final TextEditingController endOdoCtrl = TextEditingController();
  final TextEditingController customerNameCtrl =
      TextEditingController(text: 'Amritha Agencies');
  final TextEditingController customerPhoneCtrl = TextEditingController();
  final TextEditingController totalAmntCtrl = TextEditingController();
  final TextEditingController paidAmntCtrl = TextEditingController();
  final TextEditingController driverSalCtrl = TextEditingController();
  bool isRoundTrip = false;
  DateTime tripStartDate = DateTime.now();
  final Validator validate = Validator();
  ModelVehicle? vehicleDo;
  ModelUser? driverDo;

  Future<void> onSaveTrip(BuildContext context) async {
    try {
      _valid(context);
      final ModelTrip tripDo = buildTripDo();
      CallContext callContext =
          await TripApis().saveTrip(tripDo, vehicleDo!, context);
      if (!callContext.isError) {
        showInfoAlert(context, 'Succesfully saved Trip');
      }
    } catch (e) {
      debugPrint('Error Saving Trip: ' + e.toString());
    }
  }

  void _valid(BuildContext context) {
    validate.object(vehicleDo, 'Please choose Vehicle', context);
    validate.object(driverDo, 'Please choose Driver', context);
  }

  VehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        vehicle: vehicle,
        color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
        message: vehicle.getWarningMessage());
  }

  ModelTrip buildTripDo() {
    int endOdo = int.parse(endOdoCtrl.text);
    int startOdo = int.parse(startOdoCtrl.text);
    double totalAmnt = double.parse(totalAmntCtrl.text);
    double paidAmnt = double.parse(paidAmntCtrl.text);
    final ModelTrip tripDo = ModelTrip(
      startDate: Utils.getTimeStamp(tripStartDate),
      startReading: int.parse(startOdoCtrl.text),
      vehicleRegNo: vehicleDo!.registrationNo,
      driverUid: driverDo!.uid!,
      startingFrom: startingFromCtrl.text,
      destination: destinationCtrl.text,
      billAmount: totalAmnt,
      customerName: customerNameCtrl.text,
      customerPhone: customerPhoneCtrl.text,
      distance: endOdo - startOdo,
      driverName: driverDo!.fullName,
      driverSalary: double.parse(driverSalCtrl.text),
      endReading: endOdo,
      isRoundTrip: isRoundTrip,
      paidAmount: paidAmnt,
      status: Constants.ENDED,
      balanceAmount: totalAmnt - paidAmnt,
    );
    return tripDo;
  }
}
