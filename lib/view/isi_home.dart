import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:flutter_application_1/view/pesananPage/pesanan.dart';
import 'package:flutter_application_1/view/kelasSayaPage/kelasSaya.dart';
import 'package:flutter_application_1/view/riwayatPage/riwayat.dart';
import 'package:intl/intl.dart';


class IsiHome extends StatefulWidget {
  const IsiHome({super.key});

  @override
  State<IsiHome> createState() => _IsiHomeState();
}

class _IsiHomeState extends State<IsiHome> {
  final List<String> carouselImages = [
    'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1634025439/01hhrp82bcp49y60g39m6dk3de.jpg',
    'https://asthanakemang.co.id/wp-content/uploads/2024/02/gym-di-kemang.jpg',
    'https://cdn.shopify.com/s/files/1/0849/0024/9883/files/unnamed_832fb1c1-a75e-4136-be61-9f86938d1e29_480x480.jpg',
  ];

  PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < carouselImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    _pageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.pink[400],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, Users',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(color: Colors.blue[200]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          'lib/assets/logo Atma GYM.png',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  Container(
                    height: 150.0,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: carouselImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(carouselImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index; 
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(carouselImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.white
                              : Colors.white54,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(25),
                color: Colors.grey[100],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Menu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildMenuItem(Icons.list_alt_outlined, 'Pesanan',const Color.fromRGBO(116, 234, 163, 100), const PesananPage()),
                      SizedBox(
                        height: 16,
                      ),
                      buildMenuItem(Icons.sports_gymnastics, 'Kelas Saya', const Color.fromRGBO(131, 137, 252, 100), const KelasSayaPage()),
                      SizedBox(
                        height: 16,
                      ),
                      buildMenuItem(Icons.history, 'Riwayat',const Color.fromRGBO(236, 236, 127, 100), const RiwayatPage()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget buildMenuItem(IconData icon, String title, Color color, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: color,
                    child: Icon(
                      icon,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
