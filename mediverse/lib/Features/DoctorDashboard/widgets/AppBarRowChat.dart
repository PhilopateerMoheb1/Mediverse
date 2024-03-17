import 'package:flutter/material.dart';

class AppBarRowIconChat extends StatelessWidget {
  const AppBarRowIconChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.arrow_back,
          size: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.blueGrey,
          child: Image.asset(
            "assets/images/Cash.png",
            color: Colors.white,
            height: 36,
            width: 36,
          ),
        ),
      ],
    );
  }
}