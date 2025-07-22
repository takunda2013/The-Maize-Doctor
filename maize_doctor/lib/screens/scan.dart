import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maize_doctor/constants/constants.dart';
import 'package:maize_doctor/helpers/widgets/pop_stack.dart';
import 'package:maize_doctor/screens/progress_widget.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  double _currentValue = 37;
  bool process = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyConstants.secondaryBackgroundColor,

      child: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Container(
                    // fix min height to 90% of screen

                    // height: MediaQuery.of(context).size.height * 0.95,
                    decoration: BoxDecoration(
                      color: MyConstants.primaryBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Card(
                            color: MyConstants.secondaryBackgroundColor,
                            elevation: 4,
                            shadowColor: MyConstants.toneColor,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  // SizedBox(height: 12),
                                  // Text(
                                  //   "Click to upload image",
                                  //   style: TextStyle(
                                  //     fontSize: 11,
                                  //     color: Colors.grey.shade300,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  backgroundColor:
                                      MyConstants.primaryBackgroundColor,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadowColor: MyConstants.toneColor,
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.collections_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                label: Text(
                                  "Upload",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  backgroundColor:
                                      MyConstants.primaryBackgroundColor,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadowColor: MyConstants.toneColor,
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                label: Text(
                                  "Take Photo",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 0.2,
                              color: MyConstants.toneColor,
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 250,
                            child: CustomPaint(
                              painter: GaugePainter(_currentValue),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 100),

                                    Text(
                                      '${_currentValue.toInt()}',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),

                                    !process
                                        ? Container()
                                        : Text(
                                          'Processing',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[400],
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                    // Text(
                                    //   '${(_currentValue * 2.38).toStringAsFixed(1)}%',
                                    //   style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                backgroundColor:
                                    MyConstants.primaryBackgroundColor,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadowColor: MyConstants.toneColor,
                              ),
                              onPressed:
                                  process
                                      ? null
                                      : () {
                                        var x = Random().nextDouble() * 100;
                                        setState(() {
                                          _currentValue = x;
                                          // process = !process;
                                        });
                                      },
                              icon: Icon(
                                Icons.power_settings_new,
                                size: 35,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Process",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 0.2,
                              color: MyConstants.toneColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Result",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    // Icon(
                                    //   Icons.output,
                                    //   color: MyConstants.toneColor,
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 20),

                                _buildLabel(
                                  context,
                                  "Prediction",
                                  "Common Rust",
                                ),
                                SizedBox(height: 10),
                                _buildLabel(context, "Score", "97%"),

                                SizedBox(height: 15),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      backgroundColor:
                                          MyConstants.primaryBackgroundColor,
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      shadowColor: MyConstants.toneColor,
                                    ),
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.receipt,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "View Result",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   top: 8,
            //   child: Center(
            //     child: Text(
            //       "Process Image",
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //         decoration: TextDecoration.none,
            //       ),
            //     ),
            //   ),
            // ),
            PopStack(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}
