import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1), () {}),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
