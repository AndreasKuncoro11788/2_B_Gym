import 'package:flutter/material.dart';

class PesananPage extends StatelessWidget {
  const PesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan'),
      ),
      body: Center(
        child: Text('Ini adalah halaman Pesanan'),
      ),
    );
  }
}