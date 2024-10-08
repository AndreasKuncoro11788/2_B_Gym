import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data BowGym"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return const WideLayout();
        } else {
          return const NarrowLayout();
        }
      }),
    );
  }
}

// Tampilan untuk layar sempit
class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DataList(
      onDataTap: (data) => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Detail: ${data['name']}"),
                ),
                body: DataDetail(data),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Tampilan untuk layar lebar
class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Map<String, dynamic>? _selectedData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DataList(
              onDataTap: (data) => setState(() => _selectedData = data),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _selectedData == null
              ? const Center(child: Text("Pilih data untuk melihat detail"))
              : DataDetail(_selectedData!),
        ),
      ],
    );
  }
}

// Komponen untuk menampilkan list data
class DataList extends StatelessWidget {
  final void Function(Map<String, dynamic>) onDataTap;

  const DataList({super.key, required this.onDataTap});

  final List<Map<String, dynamic>> data = const [
    {
      "name": "Data Pengguna",
      "info": "Profile Pengguna",
      "image": "https://via.placeholder.com/150",
      "icon": Icons.person, // Menambahkan icon untuk Data Pengguna
    },
    {
      "name": "Personal Trainer",
      "info": "Booking Personal Trainer",
      "image": "https://via.placeholder.com/150",
      "icon": Icons.fitness_center, // Menambahkan icon untuk Personal Trainer
    },
    {
      "name": "Alat GYM",
      "info": "Rental Alat Gym",
      "image": "https://via.placeholder.com/150",
      "icon": Icons.sports_martial_arts, // Menambahkan icon untuk Alat GYM
    },
    {
      "name": "Kelas Olahraga",
      "info": "Booking Kelas Olahraga",
      "image": "https://via.placeholder.com/150",
      "icon": Icons.sports_basketball, // Menambahkan icon untuk Kelas Olahraga
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var item in data)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(
                item["icon"],
                size: 40,
                color: Colors.blue, // Menampilkan icon sesuai dengan data
              ),
              title: Text(
                item["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item["info"]!),
              onTap: () => onDataTap(item),
            ),
          ),
      ],
    );
  }
}

// Komponen untuk menampilkan detail data saat item diklik
class DataDetail extends StatelessWidget {
  final Map<String, dynamic> data;

  const DataDetail(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  data['image']!,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data['name']!,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(data['info']!),
              const SizedBox(height: 16),
              ElevatedButton(
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
