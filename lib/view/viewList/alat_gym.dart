import 'package:flutter/material.dart';

class AlatGymDetail extends StatelessWidget {
  const AlatGymDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Barbell Item
        SizedBox(
          width: 490, // Lebar dikurangi
          height: 90, // Tinggi dikurangi
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 400, // Lebar dikurangi
                height: 90, // Tinggi dikurangi
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 400, // Lebar dikurangi
                        height: 90, // Tinggi dikurangi
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBBBBBB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 31,
                      child: Text(
                        'ID Alat: BARBELL856#31',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 11,
                      child: Row(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Barbell',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 46,
                      child: Text(
                        'ID pemesanan: YOGA856#57',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12), // Jarak antar item

        // Treadmill Item
        SizedBox(
          width: 490, // Lebar dikurangi
          height: 90, // Tinggi dikurangi
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 400, // Lebar dikurangi
                height: 90, // Tinggi dikurangi
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 400, // Lebar dikurangi
                        height: 90, // Tinggi dikurangi
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBBBBBB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 62,
                      child: Text(
                        'ID Alat: TREADMILL856#32',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 11,
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_run,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Treadmill',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 46,
                      child: Text(
                        'ID pemesanan: YOGA856#58',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12), // Jarak antar item

        // Bola Gym Item
        SizedBox(
          width: 490, // Lebar dikurangi
          height: 90, // Tinggi dikurangi
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 400, // Lebar dikurangi
                height: 90, // Tinggi dikurangi
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 400, // Lebar dikurangi
                        height: 90, // Tinggi dikurangi
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBBBBBB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 31,
                      child: Text(
                        'ID Alat: BOLAGYM856#33',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 11,
                      child: Row(
                        children: [
                          Icon(
                            Icons.accessibility,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Bola Gym',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 46,
                      child: Text(
                        'ID pemesanan: YOGA856#59',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12), // Jarak antar item

        // Yoga Mat Item
        SizedBox(
          width: 490, // Lebar dikurangi
          height: 90, // Tinggi dikurangi
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 400, // Lebar dikurangi
                height: 90, // Tinggi dikurangi
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 400, // Lebar dikurangi
                        height: 90, // Tinggi dikurangi
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBBBBBB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 31,
                      child: Text(
                        'ID Alat: YOGAMAT856#34',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 11,
                      child: Row(
                        children: [
                          Icon(
                            Icons.border_all,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Yoga Mat',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 46,
                      child: Text(
                        'ID pemesanan: YOGA856#60',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: 490, // Lebar dikurangi
          height: 90, // Tinggi dikurangi
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 400, // Lebar dikurangi
                height: 90, // Tinggi dikurangi
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 400, // Lebar dikurangi
                        height: 90, // Tinggi dikurangi
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBBBBBB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 31,
                      child: Text(
                        'ID Alat: PUNCHINGBAG856#35',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 11,
                      child: Row(
                        children: [
                          Icon(
                            Icons.border_all,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Punching Bag',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 54,
                      top: 46,
                      child: Text(
                        'ID pemesanan: YOGA856#61',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
