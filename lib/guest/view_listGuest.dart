import 'package:flutter/material.dart';
import 'package:flutter_application_1/guest/viewList/alat_gymGuest.dart';
import 'package:flutter_application_1/guest/viewList/kelas_olahragaGuest.dart';
import 'package:flutter_application_1/guest/viewList/personal_trainerGuest.dart';
import 'package:flutter_application_1/guest/profileGuest.dart';

class ListViewScreenGuest extends StatelessWidget {
  const ListViewScreenGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Add "Hi, Users" and date below it in the AppBar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi, Users',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '10 Okt 2024',
                  style: TextStyle(
                    color: Colors.blue[200],
                    fontSize: 14, // Smaller text size for the date
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.pink, // Set to pink to match the design
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return const WideLayoutGuest();
        } else {
          return const NarrowLayoutGuest();
        }
      }),
    );
  }
}

class NarrowLayoutGuest extends StatelessWidget {
  const NarrowLayoutGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return DataListGuest(
      onDataTap: (data) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                "Detail: ${data['name']}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.pink,
              centerTitle: true, // Correctly placed centerTitle
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
            body: DataDetailGuest(data),
          ),
        ),
      ),
    );
  }
}

class WideLayoutGuest extends StatefulWidget {
  const WideLayoutGuest({super.key});

  @override
  State<WideLayoutGuest> createState() => _WideLayoutGuestState();
}

class _WideLayoutGuestState extends State<WideLayoutGuest> {
  Map<String, dynamic>? _selectedData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DataListGuest(
              onDataTap: (data) => setState(() => _selectedData = data),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _selectedData == null
              ? const Center(child: Text("Pilih data untuk melihat detail"))
              : DataDetailGuest(_selectedData!),
        ),
      ],
    );
  }
}

class DataListGuest extends StatelessWidget {
  final void Function(Map<String, dynamic>) onDataTap;

  const DataListGuest({super.key, required this.onDataTap});

  final List<Map<String, dynamic>> data = const [
    {
      "name": "Data Pengguna",
      "info": "Profile Pengguna",
      "icon": Icons.person,
    },
    {
      "name": "Personal Trainer",
      "info": "Booking Personal Trainer",
      "icon": Icons.fitness_center,
    },
    {
      "name": "Alat GYM",
      "info": "Rental Alat Gym",
      "icon": Icons.sports_martial_arts,
    },
    {
      "name": "Kelas Olahraga",
      "info": "Booking Kelas Olahraga",
      "icon": Icons.sports_basketball,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var item in data)
          Card(
            color: Colors.pink, // Set card background to pink
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(
                item["icon"],
                size: 40,
                color: Colors.white, // Icon color to white
              ),
              title: Text(
                item["name"]!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Text color to white
              ),
              subtitle: Text(
                item["info"]!,
                style: const TextStyle(
                    color: Colors.white70), // Subtitle color to a lighter shade
              ),
              onTap: () => onDataTap(item),
            ),
          ),
      ],
    );
  }
}

class DataDetailGuest extends StatelessWidget {
  final Map<String, dynamic> data;

  const DataDetailGuest(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    if (data['name'] == "Data Pengguna") {
      return const UserProfileGuest();
    }

    // Show details based on the selected data
    if (data['name'] == "Personal Trainer") {
      return const PersonalTrainerDetailGuest();
    }

    if (data['name'] == "Alat GYM") {
      return const AlatGymDetailGuest();
    }

    if (data['name'] == "Kelas Olahraga") {
      return const KelasOlahragaDetailGuest();
    }

    // Ini yang lama jangan dihapus dulu
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data['icon'],
                  size: 80, color: Colors.pink), // Display icon in larger size
              const SizedBox(height: 16),
              Text(
                data['name']!,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.pink),
              ),
              const SizedBox(height: 8),
              Text(data['info']!,
                  style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${data['name']} dipilih")),
                  );
                },
                child: const Text("Aksi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
