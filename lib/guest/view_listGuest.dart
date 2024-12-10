import 'package:flutter/material.dart';
import 'package:flutter_application_1/guest/homeGuest.dart';
import 'package:flutter_application_1/view/viewList/alat_gym.dart';
import 'package:flutter_application_1/view/viewList/kelas_olahraga.dart';
import 'package:flutter_application_1/view/viewList/personal_trainer.dart';
import 'package:flutter_application_1/view/Profile.dart';


class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const HomeView()),
    (route) => true, // Menghapus semua route sebelumnya
  );
},
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.pink,
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

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DataList(
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
            body: DataDetail(data),
          ),
        ),
      ),
    );
  }
}

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

class DataList extends StatelessWidget {
  final void Function(Map<String, dynamic>) onDataTap;

  const DataList({super.key, required this.onDataTap});

  final List<Map<String, dynamic>> data = const [
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
            color: Colors.pink,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(
                item["icon"],
                size: 40,
                color: Colors.white,
              ),
              title: Text(
                item["name"]!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white), 
              ),
              subtitle: Text(
                item["info"]!,
                style: const TextStyle(
                    color: Colors.white70), 
              ),
              onTap: () => onDataTap(item),
            ),
          ),
      ],
    );
  }
}

class DataDetail extends StatelessWidget {
  final Map<String, dynamic> data;

  const DataDetail(this.data, {super.key});

  @override
  Widget build(BuildContext context) {

    if (data['name'] == "Personal Trainer") {
      return const PersonalTrainerDetail();
    }

    if (data['name'] == "Alat GYM") {
      return const AlatGymDetail();
    }

    if (data['name'] == "Kelas Olahraga") {
      return const KelasOlahragaDetail();
    }

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
                  size: 80, color: Colors.pink), 
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
