import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/CheckBoxWidget.dart';
import 'package:fleezy_web/Components/DriverSearchBox.dart';
import 'package:fleezy_web/Components/FormFieldWidget.dart';
import 'package:fleezy_web/Components/VehicleSearchBox.dart';
import 'package:fleezy_web/Components/cards/VehicleCard.dart';
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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: 300,
                    child: VehicleSearchBox(onChanged: onVehicleSelected)),
                if (vehicle != null) vehicle!
              ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: 300,
                    child: DriverSearchBox(onChanged: onDriverSelected)),
                if (vehicle != null) vehicle!
              ]),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FormFieldWidget(
                  fieldName: 'Starting from',
                  controller: ctrl.startingFromCtrl),
              FormFieldWidget(
                  fieldName: 'Destination', controller: ctrl.destinationCtrl)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FormFieldWidget(
                  fieldName: 'Start Odometer Reading',
                  controller: ctrl.startOdoCtrl),
              FormFieldWidget(
                  fieldName: 'End Odometer Reading',
                  controller: ctrl.endOdoCtrl)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FormFieldWidget(
                  fieldName: 'Customer Name',
                  controller: ctrl.customerNameCtrl),
              FormFieldWidget(
                  fieldName: 'Customer Phone Number',
                  controller: ctrl.customerPhoneCtrl)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FormFieldWidget(
                  fieldName: 'Total Bill Amount',
                  controller: ctrl.totalAmntCtrl),
              FormFieldWidget(
                  fieldName: 'Received Amount', controller: ctrl.paidAmntCtrl)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FormFieldWidget(
                  fieldName: 'Driver Salary', controller: ctrl.driverSalCtrl),
              const CheckBoxWidget(fieldName: 'Round Trip')
            ]),
      ],
    );
  }

  VehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        vehicle: vehicle,
        color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
        message: vehicle.getWarningMessage());
  }

  void onVehicleSelected(ModelVehicle? vehicleModel) {
    if (vehicleModel != null) {
      vehicle = buildVehicleCard(vehicleModel);
    }
    setState(() {});
  }

  void onDriverSelected(ModelUser? driver) {}
}
