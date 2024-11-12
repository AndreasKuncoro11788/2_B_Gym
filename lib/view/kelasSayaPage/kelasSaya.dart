import 'package:flutter/material.dart';

class kelasSayaPage extends StatelessWidget {
  const kelasSayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelas Saya'),
      ),
      body: Center(
        child: Text('Ini adalah halaman Kelas'),
      ),
    );
  }
}