import 'package:dropdown_search/dropdown_search.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleSearchBox extends StatelessWidget {
  const VehicleSearchBox({required this.onChanged});

  final Function(ModelVehicle? value) onChanged;
  @override
  Widget build(BuildContext context) {
    List<ModelVehicle> vehicles =
        Provider.of<AppData>(context, listen: false).availableVehicles;
    return DropdownSearch<ModelVehicle>(
      compareFn: (ModelVehicle? i, ModelVehicle? s) =>
          i?.registrationNo == s?.registrationNo,
      showClearButton: true,
      showSearchBox: true,
      mode: Mode.MENU,
      showSelectedItems: true,
      dropdownSearchDecoration:
          kTextFieldDecoration.copyWith(labelText: 'Choose Vehicle'),
      items: vehicles,
      onChanged: onChanged,
    );
  }
}
