import 'package:flutter/material.dart';

class AddTripController {
  final TextEditingController startingFromCtrl =
      TextEditingController(text: 'Vallarpadam');
  final TextEditingController destinationCtrl =
      TextEditingController(text: 'Maruthoorkadavu');
  final TextEditingController startOdoCtrl = TextEditingController(text: '0');
  final TextEditingController endOdoCtrl = TextEditingController(text: '0');
  final TextEditingController customerNameCtrl =
      TextEditingController(text: 'Amritha Agencies');
  final TextEditingController customerPhoneCtrl = TextEditingController();
  final TextEditingController totalAmntCtrl = TextEditingController();
  final TextEditingController paidAmntCtrl = TextEditingController();
  final TextEditingController driverSalCtrl = TextEditingController();
  DateTime tripStartDate = DateTime.now();
}
