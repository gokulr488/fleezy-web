import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fleezy_web/Common/Alerts.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/Common/Validator.dart';
import 'package:fleezy_web/Components/cards/VehicleCard.dart';
import 'package:fleezy_web/DataAccess/ExpenseApis.dart';
import 'package:fleezy_web/DataAccess/FirebaseStorageService.dart';
import 'package:fleezy_web/DataModels/ModelExpense.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';

class AddFuelController {
  final TextEditingController totalAmntCtrl = TextEditingController();
  final TextEditingController fuelRateCtrl = TextEditingController();
  final TextEditingController litresFilledCtrl = TextEditingController();
  final TextEditingController odoReadingCtrl = TextEditingController();
  ModelVehicle? vehicleDo;
  ModelUser? driverDo;
  bool isFullTank = false;
  String? payMode = 'CASH';

  DateTime fuelAddedDate = DateTime.now();
  final Validator validate = Validator();

  FilePickerResult? filePickerRes;
  UploadTask? uploadTask;

  VehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        vehicle: vehicle,
        color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
        message: vehicle.getWarningMessage());
  }

//TODO auto update values based on fule calculations
  Future<void> onAddFuel(BuildContext context) async {
    try {
      _valid(context);
      uploadTask = FirebaseStorageService.uploadPickerRes(
          Constants.FUEL_BILLS_FOLDER, filePickerRes);
      final ModelExpense expenseDo = buildExpenseDo();
      CallContext callContext =
          await ExpenseApis().addNewExpense(expenseDo, vehicleDo!, context);
      if (!callContext.isError) {
        showInfoAlert(context, 'Succesfully Added Fuel');
      }
    } catch (e) {
      debugPrint('Error Adding Fuel: ' + e.toString());
    }
  }

  void _valid(BuildContext context) {
    validate.object(filePickerRes, 'Choose Bill image', context);
    validate.object(vehicleDo, 'Please choose Vehicle', context);
    validate.object(driverDo, 'Please choose Driver', context);
    validate.stringField(totalAmntCtrl.text, 'Invalid Total Amount', context,
        isNumber: true);
    validate.stringField(fuelRateCtrl.text, 'Invalid Price per litre', context,
        isNumber: true);
    validate.stringField(
        litresFilledCtrl.text, 'Invalid Litres Filles', context,
        isNumber: true);
    validate.stringField(
        odoReadingCtrl.text, 'Invalid Odometer reading', context,
        isNumber: true);
  }

  ModelExpense buildExpenseDo() {
    int odoReading = double.parse(odoReadingCtrl.text).toInt();
    double amount = double.parse(totalAmntCtrl.text);
    double fuelQty = double.parse(litresFilledCtrl.text);
    double untiPrice = double.parse(fuelRateCtrl.text);
    String imagePath = uploadTask!.snapshot.ref.fullPath;
    final ModelExpense expenseDo = ModelExpense(
        amount: amount,
        expenseType: Constants.FUEL,
        odometerReading: odoReading,
        timestamp: Utils.getTimeStamp(fuelAddedDate),
        driverName: driverDo!.fullName,
        fuelQty: fuelQty,
        fuelUnitPrice: untiPrice,
        imagePath: imagePath,
        isFullTank: isFullTank,
        payMode: payMode,
        vehicleRegNo: vehicleDo!.registrationNo);
    return expenseDo;
  }

  Future<void> onChooseFilePressed(BuildContext context) async {
    filePickerRes = await FilePicker.platform.pickFiles();
  }
}
