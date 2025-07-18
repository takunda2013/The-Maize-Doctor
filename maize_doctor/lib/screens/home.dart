import 'package:flutter/material.dart';
import 'package:maize_doctor/constants/constants.dart';
import 'package:maize_doctor/helpers/widgets/home_cards.dart';

class DoctorAppScreen extends StatelessWidget {
  const DoctorAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                      Text(
                        'User x3000b',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: MyConstants.toneColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.menu, color: Colors.black, size: 20),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: MyConstants.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: MyConstants.toneColor, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'Search Doctor',
                      style: TextStyle(color: Colors.grey[400], fontSize: 16),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Featured Doctor Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyConstants.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Kelly Allow',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Neurologist Surgeon',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: MyConstants.toneColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '5.0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '(2234 reviews)',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Colors.grey[400]),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Categories
              SizedBox(height: 24),

              // Favourite Doctor Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Favourite Doctor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: MyConstants.toneColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Doctor Cardsi
              Row(
                children: [
                  Expanded(
                    child: HomeCards(
                      name: 'Dr. Alex Johnson',
                      specialty: 'Paediatrician',
                      imageUrl:
                          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: HomeCards(
                      name: 'Dr. Esther Howard',
                      specialty: 'Radiologist',
                      imageUrl:
                          'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400&h=400&fit=crop',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildCategoryChip(String label, bool isSelected) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     decoration: BoxDecoration(
  //       color:
  //           isSelected
  //               ? MyConstants.toneColor
  //               : MyConstants.secondaryBackgroundColor,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Text(
  //       label,
  //       style: TextStyle(
  //         color: isSelected ? Colors.black : Colors.grey[400],
  //         fontSize: 14,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }
}
