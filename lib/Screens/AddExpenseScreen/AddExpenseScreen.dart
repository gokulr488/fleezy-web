import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/Components/DatePicker.dart';
import 'package:fleezy_web/Components/DriverSearchBox.dart';
import 'package:fleezy_web/Components/DropDown.dart';
import 'package:fleezy_web/Components/FormFieldWidget.dart';
import 'package:fleezy_web/Components/RoundedButton.dart';
import 'package:fleezy_web/Components/VehicleSearchBox.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:fleezy_web/Screens/AddExpenseScreen/AddExpenseController.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen();

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  AddExpenseController ctrl = AddExpenseController();
  Widget? vehicle;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: [
          Expanded(
              child: Column(children: [
            VehicleSearchBox(onChanged: onVehicleSelected),
            const SizedBox(height: 30),
            DriverSearchBox(onChanged: onDriverSelected),
            DropDown(
                onChanged: (value) => ctrl.expenseType = value!,
                defaultValue: Constants.FASTAG,
                values: Constants.EXPENSE_TYPES,
                hintText: 'Expense Type'),
            FormFieldWidget(fieldName: 'Amount', controller: ctrl.amntCtrl),
            FormFieldWidget(
                fieldName: 'Odometer Reading', controller: ctrl.odoReadingCtrl),
            RoundedButton(
                title: 'Select Image',
                width: 150,
                onPressed: () async {
                  await ctrl.onChooseFilePressed(context);
                  setState(() {});
                })
          ])),
          Expanded(
              child: Column(children: [
            vehicle != null ? vehicle! : const SizedBox(height: 110),
            DatePicker(
                label: 'Date  ',
                onTap: () async {
                  ctrl.expenseAddedDate = await Utils.pickDate(context);
                  setState(() {});
                },
                text: Utils.getFormattedDate(
                    ctrl.expenseAddedDate, Constants.kUiDateFormat)),
            const SizedBox(height: 15),
            TextFormField(
                minLines: 7,
                maxLines: 8,
                controller: ctrl.expenseDetailCtrl,
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Details of Expense')),
            _getPhotoWidget(),
            const Spacer(),
            RoundedButton(
                title: 'Add fuel expense',
                width: 300,
                onPressed: () => ctrl.onAddExpense(context))
          ]))
        ]));
  }

  Widget _getPhotoWidget() {
    String text = (ctrl.filePickerRes == null)
        ? 'Bill Image not Selected'
        : ctrl.filePickerRes!.files.first.name;
    return SizedBox(
      width: 400,
      child: Center(child: Text(text, style: const TextStyle(fontSize: 16))),
    );
  }

  void onVehicleSelected(ModelVehicle? vehicleModel) {
    if (vehicleModel != null) {
      vehicle = ctrl.buildVehicleCard(vehicleModel);
      ctrl.vehicleDo = vehicleModel;
      ctrl.odoReadingCtrl.text = vehicleModel.latestOdometerReading.toString();
    }
    setState(() {});
  }

  void onDriverSelected(ModelUser? driver) {
    if (driver != null) {
      ctrl.driverDo = driver;
    }
  }
}
