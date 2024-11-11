import 'package:flutter/material.dart';

class PesananPage extends StatelessWidget {
  const PesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> kelasList = ['Kelas Yoga', 'Kelas Pilates', 'Kelas Zumba'];
    final List<String> trainerList = ['Trainer A', 'Trainer B', 'Trainer C'];
    final List<String> alatGymList = ['Treadmill', 'Dumbbell', 'Barbell'];
    final List<String> jadwalList = ['Pagi', 'Siang', 'Sore'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.pink,
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Nama Pengguna',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    hintText: 'Masukkan nama pengguna',
                    prefixIcon: const Icon(Icons.person, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Kelas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    prefixIcon: const Icon(Icons.fitness_center, color: Colors.black),
                  ),
                  items: kelasList.map((String kelas) {
                    return DropdownMenuItem<String>(
                      value: kelas,
                      child: Text(kelas),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  hint: const Text('Pilih kelas'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Trainer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    prefixIcon: const Icon(Icons.person_pin, color: Colors.black),
                  ),
                  items: trainerList.map((String trainer) {
                    return DropdownMenuItem<String>(
                      value: trainer,
                      child: Text(trainer),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  hint: const Text('Pilih trainer'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Alat Gym',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    prefixIcon: const Icon(Icons.sports_gymnastics, color: Colors.black),
                  ),
                  items: alatGymList.map((String alat) {
                    return DropdownMenuItem<String>(
                      value: alat,
                      child: Text(alat),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  hint: const Text('Pilih alat gym'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Jadwal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    prefixIcon: const Icon(Icons.schedule, color: Colors.black),
                  ),
                  items: jadwalList.map((String jadwal) {
                    return DropdownMenuItem<String>(
                      value: jadwal,
                      child: Text(jadwal),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  hint: const Text('Pilih jadwal'),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Pesan Sekarang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
