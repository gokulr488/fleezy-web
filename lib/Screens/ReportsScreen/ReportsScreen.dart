import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/Components/DatePicker.dart';
import 'package:fleezy_web/Components/RoundedButton.dart';
import 'package:fleezy_web/Screens/ReportsScreen/ReportsController.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportsController ctrl = ReportsController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        DatePicker(
            label: 'Date  ',
            onTap: () async {
              ctrl.selectedDate = await Utils.pickDate(context);
              setState(() {});
            },
            text: Utils.getFormattedDate(
                ctrl.selectedDate, Constants.kUiDateFormat)),
        RoundedButton(
            title: 'Generate Reports',
            width: 300,
            onPressed: () => ctrl.generateReports(context))
      ]),
    );
  }
}
