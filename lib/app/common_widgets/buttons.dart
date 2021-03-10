import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  Widget build(BuildContext context) {
    print("$title onPressed: $onPressed");
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey; // Disabled color
          }
          return Colors.blue; // Regular color
        }),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
