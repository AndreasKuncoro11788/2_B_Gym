
import 'package:flutter/material.dart';
import 'package:2_B_Gym/View/home.dart';
import 'package:2_B_Gym/View/login.dart';
import 'package:2_B_Gym/View/profile.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}

