import 'package:flutter/material.dart';
import 'package:guidedlayout2_1788/View/home.dart';
import 'package:guidedlayout2_1788/View/login.dart';
import 'package:guidedlayout2_1788/View/profile.dart';

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