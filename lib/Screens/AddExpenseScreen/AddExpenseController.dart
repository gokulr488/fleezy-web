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

class AddExpenseController {
  final TextEditingController amntCtrl = TextEditingController();
  final TextEditingController odoReadingCtrl = TextEditingController();
  final TextEditingController expenseDetailCtrl = TextEditingController();
  ModelVehicle? vehicleDo;
  ModelUser? driverDo;

  DateTime expenseAddedDate = DateTime.now();
  final Validator validate = Validator();

  FilePickerResult? filePickerRes;
  UploadTask? uploadTask;

  String expenseType = Constants.FASTAG;

  VehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        vehicle: vehicle,
        color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
        message: vehicle.getWarningMessage());
  }

  Future<void> onAddExpense(BuildContext context) async {
    try {
      if (_valid(context)) {
        showSendingDialogue(context);
        if (filePickerRes != null) {
          uploadTask = FirebaseStorageService.uploadPickerRes(
              Constants.EXPENSE_BILLS_FOLDER, filePickerRes);
        }
        final ModelExpense expenseDo = buildExpenseDo();
        CallContext callContext =
            await ExpenseApis().addNewExpense(expenseDo, vehicleDo!, context);
        if (!callContext.isError) {
          Navigator.pop(context);
          showInfoAlert(context, 'Succesfully Added Expense');
        }
      }
    } catch (e) {
      Navigator.pop(context);
      debugPrint('Error Adding Expense: ' + e.toString());
      showErrorAlert(context, 'Error Adding Expense: ' + e.toString());
    }
  }

  bool _valid(BuildContext context) {
    try {
      //validate.object(filePickerRes, 'Choose Bill image', context);
      validate.object(vehicleDo, 'Please choose Vehicle', context);
      validate.object(driverDo, 'Please choose Driver', context);
      validate.stringField(amntCtrl.text, 'Invalid Total Amount', context,
          isNumber: true);
      validate.stringField(
          odoReadingCtrl.text, 'Invalid Odometer reading', context,
          isNumber: true);
      int? odoReading = double.tryParse(odoReadingCtrl.text)?.toInt();
      validate.odometerReading(
          odoReading, vehicleDo!.latestOdometerReading, context);
      return true;
    } catch (e) {
      debugPrint('Error Adding Expense: ' + e.toString());
      return false;
    }
  }

  ModelExpense buildExpenseDo() {
    int odoReading = double.parse(odoReadingCtrl.text).toInt();
    double amount = double.parse(amntCtrl.text);
    String? imagePath = uploadTask?.snapshot.ref.fullPath;
    final ModelExpense expenseDo = ModelExpense(
        amount: amount,
        expenseType: expenseType,
        odometerReading: odoReading,
        timestamp: Utils.getTimeStamp(expenseAddedDate),
        driverName: driverDo!.fullName,
        imagePath: imagePath,
        expenseDetails: expenseDetailCtrl.text,
        vehicleRegNo: vehicleDo!.registrationNo);
    return expenseDo;
  }

  Future<void> onChooseFilePressed(BuildContext context) async {
    filePickerRes = await FilePicker.platform.pickFiles();
  }
}
