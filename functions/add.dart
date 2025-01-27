import 'package:flutter/material.dart';

Future<void> showAddDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Add Item"),
      content: Text("This is the add dialog."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        ),
      ],
    ),
  );
}
