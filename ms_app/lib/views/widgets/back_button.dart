import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Widget destinationPage;

  const CustomBackButton({Key? key, required this.destinationPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
    );
  }
}
