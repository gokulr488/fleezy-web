import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({required this.onTap, required this.text});
  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text,
                style: const TextStyle(
                  fontSize: 20,
                  color: kHighlightColour,
                  fontWeight: FontWeight.bold,
                )),
            const Icon(Icons.date_range, color: kHighlightColour, size: 30)
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
