import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({required this.fieldName, required this.controller});
  final String fieldName;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(fieldName,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          SizedBox(
            width: 400,
            height: 45,
            child: TextFormField(
              controller: controller,
              decoration: kTextFieldDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
