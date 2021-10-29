import 'package:fleezy_web/Components/VehicleSearchBox.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';

class AddTripScreen extends StatelessWidget {
  const AddTripScreen();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
                width: 300,
                child: VehicleSearchBox(onChanged: (ModelVehicle? vehicle) {}))
          ],
        )
      ],
    );
  }
}
