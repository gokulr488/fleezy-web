import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fleezy_web/Common/Alerts.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/UiState.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/Common/Validator.dart';
import 'package:fleezy_web/Components/cards/VehicleCard.dart';
import 'package:fleezy_web/DataAccess/FirebaseStorageService.dart';
import 'package:fleezy_web/DataAccess/TripApis.dart';
import 'package:fleezy_web/DataModels/ModelTrip.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:fleezy_web/Screens/AddTripScreen/AddTripScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  FilePickerResult? filePickerRes;
  UploadTask? uploadTask;

  Future<void> onSaveTrip(BuildContext context) async {
    try {
      if (_valid(context)) {
        showSendingDialogue(context);
        uploadTask = FirebaseStorageService.uploadPickerRes(
            Constants.TRIP_BILLS_FOLDER, filePickerRes);
        final ModelTrip tripDo = buildTripDo();
        CallContext callContext =
            await TripApis().saveTrip(tripDo, vehicleDo!, context);
        Navigator.pop(context);
        if (!callContext.isError) {
          showInfoAlert(context, 'Succesfully saved Trip');
          Provider.of<UiState>(context, listen: false)
              .setCenterWidget(const AddTripScreen());
        }
      }
    } catch (e) {
      Navigator.pop(context);
      debugPrint('Error Saving Trip: ' + e.toString());
      showErrorAlert(context, 'Error Saving Trip: ' + e.toString());
    }
  }

  bool _valid(BuildContext context) {
    try {
      validate.object(filePickerRes, 'Choose Bill image', context);
      validate.object(vehicleDo, 'Please choose Vehicle', context);
      validate.object(driverDo, 'Please choose Driver', context);
      validate.stringField(
          startingFromCtrl.text, 'Starting From cannot be empty', context);
      validate.stringField(
          destinationCtrl.text, 'Destination cannot be empty', context);
      validate.stringField(
          startOdoCtrl.text, 'Invalid Start Odometer reading', context,
          isNumber: true);
      validate.stringField(
          endOdoCtrl.text, 'Invalid End Odometer reading', context,
          isNumber: true);
      validate.stringField(
          customerNameCtrl.text, 'Customer Name cannot be empty', context);
      validate.stringField(totalAmntCtrl.text, 'Invalid Total Amount', context,
          isNumber: true);
      validate.stringField(
          paidAmntCtrl.text, 'Invalid Received Amount cannot be empty', context,
          isNumber: true);
      validate.stringField(
          driverSalCtrl.text, 'Invalid Driver salary cannot be empty', context,
          isNumber: true);
      int? endodoReading = double.tryParse(endOdoCtrl.text)?.toInt();
      validate.odometerReading(
          endodoReading, vehicleDo!.latestOdometerReading, context);
      int? startOdoReading = double.tryParse(startOdoCtrl.text)?.toInt();
      validate.odometerReading(
          startOdoReading, vehicleDo!.latestOdometerReading, context);
      return true;
    } catch (e) {
      debugPrint('Error Saving Trip: ' + e.toString());
      return false;
    }
  }

  VehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        vehicle: vehicle,
        color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
        message: vehicle.getWarningMessage());
  }

  ModelTrip buildTripDo() {
    int endOdo = double.parse(endOdoCtrl.text).toInt();
    int startOdo = double.parse(startOdoCtrl.text).toInt();
    double totalAmnt = double.parse(totalAmntCtrl.text);
    double paidAmnt = double.parse(paidAmntCtrl.text);
    String imagePath = uploadTask!.snapshot.ref.fullPath;
    final ModelTrip tripDo = ModelTrip(
      startDate: Utils.getTimeStamp(tripStartDate),
      startReading: startOdo,
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
      imagePath: imagePath,
    );
    return tripDo;
  }

  Future<void> onChooseFilePressed(BuildContext context) async {
    filePickerRes = await FilePicker.platform.pickFiles();
  }
}
