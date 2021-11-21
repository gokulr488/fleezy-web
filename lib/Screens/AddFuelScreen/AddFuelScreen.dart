import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/Utils.dart';
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
            DriverSearchBox(onChanged: onDriverSelected),
            DropDown(
                onChanged: (value) {
                  debugPrint(value);
                },
                defaultValue: 'CASH',
                values: const <String>['CASH', 'BPL Card', 'Debit Card']),
            FormFieldWidget(
                fieldName: 'Total Amount', controller: ctrl.totalAmntCtrl),
            FormFieldWidget(
                fieldName: 'Price Per Litre', controller: ctrl.fuelRateCtrl),
            FormFieldWidget(
                fieldName: 'Litres filled', controller: ctrl.litresFilledCtrl),
            FormFieldWidget(
                fieldName: 'Odometer Reading', controller: ctrl.odoReadingCtrl),
          ])),
          Expanded(
              child: Column(children: [
            if (vehicle != null) vehicle!,
            DatePicker(
                label: 'Date  ',
                onTap: () async {
                  ctrl.tripStartDate = await Utils.pickDate(context);
                  setState(() {});
                },
                text: Utils.getFormattedDate(
                    ctrl.tripStartDate, Constants.kUiDateFormat)),
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

  void onVehicleSelected(ModelVehicle? vehicleModel) {
    if (vehicleModel != null) {
      vehicle = ctrl.buildVehicleCard(vehicleModel);
    }
    setState(() {});
  }

  void onDriverSelected(ModelUser? driver) {}
}
