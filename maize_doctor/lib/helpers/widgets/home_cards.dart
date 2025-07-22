import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maize_doctor/constants/constants.dart';
import 'package:maize_doctor/screens/scan.dart';

class HomeCards extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String specialty;
  const HomeCards({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.specialty,
  });

  @override
  State<HomeCards> createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          tapped = true;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Scan()),
        );
        await Future.delayed(Duration(milliseconds: 30));
        setState(() {
          tapped = false;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              tapped
                  ? Colors.grey.withValues(alpha: 0.5)
                  : MyConstants.secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior:
                  Clip.none, // This allows the circle to extend beyond the image bounds
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -8, // Negative value to push it outside the image
                  right: -8, // Negative value to push it outside the image
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: MyConstants.toneColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Icon(Icons.favorite, color: Colors.black, size: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              widget.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.specialty,
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
