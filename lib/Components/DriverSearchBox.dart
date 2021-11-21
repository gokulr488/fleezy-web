import 'package:dropdown_search/dropdown_search.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverSearchBox extends StatelessWidget {
  const DriverSearchBox({required this.onChanged});

  final Function(ModelUser? user) onChanged;
  @override
  Widget build(BuildContext context) {
    List<ModelUser>? drivers =
        Provider.of<AppData>(context, listen: false).drivers;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownSearch<ModelUser>(
        compareFn: compareFn,
        showClearButton: true,
        showSearchBox: true,
        mode: Mode.MENU,
        showSelectedItems: true,
        dropdownSearchDecoration:
            kTextFieldDecoration.copyWith(labelText: 'Select Driver'),
        items: drivers,
        onChanged: onChanged,
      ),
    );
  }

  bool compareFn(ModelUser? i, ModelUser? s) {
    return i?.phoneNumber == s?.phoneNumber;
  }
}
