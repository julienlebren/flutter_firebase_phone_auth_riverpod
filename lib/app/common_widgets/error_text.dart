import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.0),
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 17),
      ),
    );
  }
}
