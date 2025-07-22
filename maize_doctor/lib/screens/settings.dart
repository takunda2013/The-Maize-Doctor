import 'package:flutter/material.dart';
import 'package:maize_doctor/constants/constants.dart';
import 'package:maize_doctor/helpers/widgets/pop_stack.dart';

class MySettings extends StatelessWidget {
  const MySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyConstants.primaryBackgroundColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Divider(),
                ],
              ),
              PopStack(),
            ],
          ),
        ),
      ),
    );
  }
}
