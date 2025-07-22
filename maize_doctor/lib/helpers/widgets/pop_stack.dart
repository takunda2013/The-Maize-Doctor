import 'package:flutter/material.dart';
import 'package:maize_doctor/constants/constants.dart';

class PopStack extends StatelessWidget {
  const PopStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 8,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Card(
          color: MyConstants.toneColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }
}
