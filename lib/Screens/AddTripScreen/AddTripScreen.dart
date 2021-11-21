import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/Components/CheckBoxWidget.dart';
import 'package:fleezy_web/Components/DatePicker.dart';
import 'package:fleezy_web/Components/DriverSearchBox.dart';
import 'package:fleezy_web/Components/FormFieldWidget.dart';
import 'package:fleezy_web/Components/RoundedButton.dart';
import 'package:fleezy_web/Components/VehicleSearchBox.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:fleezy_web/Screens/AddTripScreen/AddTripController.dart';
import 'package:flutter/material.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen();

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  AddTripController ctrl = AddTripController();
  Widget? vehicle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                label: 'Trip Start Date  ',
                onTap: () async {
                  ctrl.tripStartDate = await Utils.pickDate(context);
                  setState(() {});
                },
                text: Utils.getFormattedDate(
                    ctrl.tripStartDate, Constants.kUiDateFormat))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FormFieldWidget(
                fieldName: 'Starting from', controller: ctrl.startingFromCtrl),
            FormFieldWidget(
                fieldName: 'Destination', controller: ctrl.destinationCtrl)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FormFieldWidget(
                fieldName: 'Start Odometer Reading',
                controller: ctrl.startOdoCtrl),
            FormFieldWidget(
                fieldName: 'End Odometer Reading', controller: ctrl.endOdoCtrl)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FormFieldWidget(
                fieldName: 'Customer Name', controller: ctrl.customerNameCtrl),
            FormFieldWidget(
                fieldName: 'Customer Phone Number',
                controller: ctrl.customerPhoneCtrl)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FormFieldWidget(
                fieldName: 'Total Bill Amount', controller: ctrl.totalAmntCtrl),
            FormFieldWidget(
                fieldName: 'Received Amount', controller: ctrl.paidAmntCtrl)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FormFieldWidget(
                fieldName: 'Driver Salary', controller: ctrl.driverSalCtrl),
            CheckBoxWidget(
              fieldName: 'Round Trip',
              initialValue: ctrl.isRoundTrip,
              onChanged: (bool? value) {
                ctrl.isRoundTrip = value ?? false;
                setState(() {});
              },
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RoundedButton(
                title: 'Select Image',
                width: 300,
                onPressed: () async {
                  await ctrl.onChooseFilePressed(context);
                  setState(() {});
                }),
            _getPhotoWidget()
          ]),
          const Spacer(),
          RoundedButton(
              title: 'Save Trip',
              width: 300,
              onPressed: () {
                ctrl.onSaveTrip(context);
              })
        ],
      ),
    );
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
