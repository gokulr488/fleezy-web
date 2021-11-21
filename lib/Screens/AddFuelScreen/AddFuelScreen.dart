import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/Components/CheckBoxWidget.dart';
import 'package:fleezy_web/Components/DatePicker.dart';
import 'package:fleezy_web/Components/DriverSearchBox.dart';
import 'package:fleezy_web/Components/DropDown.dart';
import 'package:fleezy_web/Components/FormFieldWidget.dart';
import 'package:fleezy_web/Components/RoundedButton.dart';
import 'package:fleezy_web/Components/VehicleSearchBox.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:fleezy_web/Screens/AddFuelScreen/AddFuelController.dart';
import 'package:flutter/material.dart';

class AddFuelScreen extends StatefulWidget {
  const AddFuelScreen();

  @override
  State<AddFuelScreen> createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  AddFuelController ctrl = AddFuelController();
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
                onChanged: (value) => ctrl.payMode = value,
                defaultValue: 'CASH',
                values: const <String>['CASH', 'BPL Card', 'Debit Card']),
            FormFieldWidget(
                fieldName: 'Total Amount', controller: ctrl.totalAmntCtrl),
            FormFieldWidget(
                fieldName: 'Price Per Litre', controller: ctrl.fuelRateCtrl),
            RoundedButton(
                title: 'Select Image',
                width: 300,
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
                  ctrl.fuelAddedDate = await Utils.pickDate(context);
                  setState(() {});
                },
                text: Utils.getFormattedDate(
                    ctrl.fuelAddedDate, Constants.kUiDateFormat)),
            CheckBoxWidget(
              fieldName: 'Full Tank',
              initialValue: ctrl.isFullTank,
              onChanged: (bool? value) {
                ctrl.isFullTank = value ?? false;
                setState(() {});
              },
            ),
            FormFieldWidget(
                fieldName: 'Litres filled', controller: ctrl.litresFilledCtrl),
            FormFieldWidget(
                fieldName: 'Odometer Reading', controller: ctrl.odoReadingCtrl),
            _getPhotoWidget(),
            const Spacer(),
            RoundedButton(
                title: 'Add fuel expense',
                width: 300,
                onPressed: () {
                  ctrl.onAddFuel(context);
                })
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
    }
    setState(() {});
  }

  void onDriverSelected(ModelUser? driver) {
    if (driver != null) {
      ctrl.driverDo = driver;
    }
  }
}
