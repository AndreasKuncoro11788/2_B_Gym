import 'package:flutter/material.dart';

class PersonalTrainerDetailGuest extends StatelessWidget {
  const PersonalTrainerDetailGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        TrainerCard(
          name: 'Agus',
          trainerType: 'Yoga',
          idOrder: 'YOGA856#57',
          idNumber: '1234567',
        ),
        TrainerCard(
          name: 'Bowoo',
          trainerType: 'Zumba',
          idOrder: 'ZUMBA856#58',
          idNumber: '2345678',
        ),
        TrainerCard(
          name: 'Charlie',
          trainerType: 'Boxing',
          idOrder: 'BOXING856#59',
          idNumber: '3456789',
        ),
        TrainerCard(
          name: 'Deven',
          trainerType: 'Pilates',
          idOrder: 'PILATES856#60',
          idNumber: '4567890',
        ),
        TrainerCard(
          name: 'Evan',
          trainerType: 'Body Combat',
          idOrder: 'BODYCOMBAT856#61',
          idNumber: '5678901',
        ),
      ],
    );
  }
}

class TrainerCard extends StatelessWidget {
  final String name;
  final String trainerType;
  final String idOrder;
  final String idNumber;

  const TrainerCard({
    required this.name,
    required this.trainerType,
    required this.idOrder,
    required this.idNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color.fromARGB(91, 224, 224, 224),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trainer: $trainerType'),
            Text('ID pemesanan: $idOrder'),
            Text('Nomor identitas: $idNumber'),
          ],
        ),
      ),
    );
  }
}