import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/PersonalTrainerClient.dart'; 
import 'package:flutter_application_1/entity/PersonalTrainer.dart'; 
import 'package:flutter_animate/flutter_animate.dart'; 

class PersonalTrainerDetail extends StatelessWidget {
  const PersonalTrainerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PersonalTrainer>>(
        future: PersonalTrainerClient().fetchPersonalTrainers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No trainers found.'));
          }

          final trainers = snapshot.data!;

          return ListView.builder(
            itemCount: trainers.length,
            itemBuilder: (context, index) {
              final trainer = trainers[index];
              return TrainerCard(trainer: trainer)
                  .animate()
                  .fade(duration: 500.ms)
                  .slide();
            },
          );
        },
      ),
    );
  }
}

class TrainerCard extends StatelessWidget {
  final PersonalTrainer trainer;

  const TrainerCard({Key? key, required this.trainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.blueAccent, 
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(_getImageByIdentity(trainer
                      .nomorIdentitas)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainer.namaTrainer,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nomor Identitas: ${trainer.nomorIdentitas}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getImageByIdentity(String identity) {
    
    return 'lib/assets/default_trainer.jpg'; 
  }
}
