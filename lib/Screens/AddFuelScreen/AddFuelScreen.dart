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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                width: 300,
                child: VehicleSearchBox(onChanged: onVehicleSelected)),
            if (vehicle != null) vehicle!
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                width: 300,
                child: DriverSearchBox(onChanged: onDriverSelected)),
            DatePicker(
                label: 'Date  ',
                onTap: () async {
                  ctrl.tripStartDate = await Utils.pickDate(context);
                  setState(() {});
                },
                text: Utils.getFormattedDate(
                    ctrl.tripStartDate, Constants.kUiDateFormat))
          ]),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 300,
                child: DropDown(
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    defaultValue: 'CASH',
                    values: const <String>['CASH', 'BPL Card', 'Debit Card']),
              ),
            ],
          ),
          FormFieldWidget(
              fieldName: 'Total Amount', controller: ctrl.totalAmntCtrl),
          FormFieldWidget(
              fieldName: 'Price Per Litre', controller: ctrl.fuelRateCtrl),
          FormFieldWidget(
              fieldName: 'Litres filled', controller: ctrl.litresFilledCtrl),
          FormFieldWidget(
              fieldName: 'Odometer Reading', controller: ctrl.odoReadingCtrl),
          const Spacer(),
          RoundedButton(
              title: 'Add fuel expense',
              width: 300,
              onPressed: () {
                ctrl.onAddFuel(context);
              })
        ],
      ),
    );
  }

  void onVehicleSelected(ModelVehicle? vehicleModel) {
    if (vehicleModel != null) {
      vehicle = ctrl.buildVehicleCard(vehicleModel);
    }
    setState(() {});
  }

  void onDriverSelected(ModelUser? driver) {}
}
