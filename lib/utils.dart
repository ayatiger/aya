import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Loading...'),
              ),
            ],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(String message, BuildContext context, String posActionText,
    Function posAction,
    {String? negActionText, Function? negAction}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                posAction(context);
              },
              child: Text(posActionText))
        ],
      );
    },
  );
}
