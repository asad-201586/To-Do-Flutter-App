import 'package:flutter/material.dart';
import 'package:to_do_flutter/ui/buttons/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task"
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              // save button
              MyButton(text: "Save", onPressed: onSave),
              const SizedBox(width: 20),
              // cancel button
              MyButton(text: "Cancel", onPressed: onCancel),
            ],)
          ],
        ),
      ),
    );
  }
}
