import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/LoadingDots.dart';
import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {
  const Alerts({
    required this.title,
    required this.actions,
  });
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        actions: actions,
        backgroundColor: kAlertColor,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))));
  }
}

void showSendingDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Alerts(
        title: 'Submitting...',
        actions: [LoadingDots(size: 50)],
      );
    },
  );
}

void showSubmitResponse(BuildContext context, String resp) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alerts(title: resp, actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'))
      ]);
    },
  );
}

void showErrorAlert(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alerts(
        title: 'ERROR',
        actions: [
          Text(errorMessage, style: const TextStyle(fontSize: 18)),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'))
        ],
      );
    },
  );
}

void showWarningAlert(
    BuildContext context, String errorMessage, Function onConfirmed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alerts(
        title: 'Warning',
        actions: [
          Text(errorMessage, style: const TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No')),
              TextButton(
                  onPressed: () => onConfirmed(), child: const Text('Yes'))
            ],
          ),
        ],
      );
    },
  );
}

void showInfoAlert(BuildContext context, String infoMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alerts(
        title: 'Info',
        actions: [
          Text(infoMessage, style: const TextStyle(fontSize: 18)),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK')),
        ],
      );
    },
  );
}
