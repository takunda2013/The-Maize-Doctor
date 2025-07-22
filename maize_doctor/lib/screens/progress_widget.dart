import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:maize_doctor/constants/constants.dart';

class RevCounterGauge extends StatefulWidget {
  @override
  _RevCounterGaugeState createState() => _RevCounterGaugeState();
}

class _RevCounterGaugeState extends State<RevCounterGauge>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _currentValue = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animation.addListener(() {
      setState(() {
        _currentValue = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startSimulation() {
    setState(() {
      _isRunning = true;
    });
    _animationController.forward();
  }

  void _resetCounter() {
    setState(() {
      _isRunning = false;
      _currentValue = 0;
    });
    _animationController.reset();
  }

  Color _getColor(double value) {
    if (value <= 33) return Colors.red;
    if (value <= 66) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Rev Counter Gauge', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: GaugePainter(_currentValue),
                // child: Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SizedBox(height: 80),

                //       Text(
                //         '${_currentValue.toInt()}',
                //         style: TextStyle(
                //           fontSize: 48,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //         ),
                //       ),

                //       Text(
                //         'Processing',
                //         style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                //       ),
                //       // Text(
                //       //   '${(_currentValue * 2.38).toStringAsFixed(1)}%',
                //       //   style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                //       // ),
                //     ],
                //   ),
                // ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startSimulation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _resetCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Reset'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Slider(
              value: _currentValue,
              max: 100,
              divisions: 100,
              activeColor: _getColor(_currentValue),
              inactiveColor: Colors.grey[700],
              onChanged:
                  _isRunning
                      ? null
                      : (value) {
                        setState(() {
                          _currentValue = value;
                        });
                      },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Manual Control',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double value;

  GaugePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;

    // Background arc
    final backgroundPaint =
        Paint()
          ..color = Colors.grey[800]!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi, // Start angle
      math.pi * 1.0, // Sweep angle
      false,
      backgroundPaint,
    );

    // Progress arc
    final progressPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;

    // Color gradient based on value
    if (value <= 33) {
      progressPaint.color = Colors.red;
    } else if (value <= 66) {
      progressPaint.color = Colors.orange;
    } else {
      progressPaint.color = Colors.green;
    }

    final sweepAngle = (value / 100) * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi,
      sweepAngle,
      false,
      progressPaint,
    );

    // Needle
    final needleAngle = -math.pi + sweepAngle;
    final needleLength = radius - 25;
    final needleEnd = Offset(
      center.dx + needleLength * math.cos(needleAngle),
      center.dy + needleLength * math.sin(needleAngle),
    );

    final needlePaint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, needleEnd, needlePaint);

    // Center dot
    final centerDotPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8, centerDotPaint);

    // Scale marks
    final scalePaint =
        Paint()
          ..color = Colors.grey[600]!
          ..strokeWidth = 2;

    for (int i = 0; i <= 10; i++) {
      final angle = -math.pi + (i / 10) * math.pi * 1.0;
      final startRadius = radius + 5;
      final endRadius = radius + 15;

      final start = Offset(
        center.dx + startRadius * math.cos(angle),
        center.dy + startRadius * math.sin(angle),
      );
      final end = Offset(
        center.dx + endRadius * math.cos(angle),
        center.dy + endRadius * math.sin(angle),
      );

      canvas.drawLine(start, end, scalePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
