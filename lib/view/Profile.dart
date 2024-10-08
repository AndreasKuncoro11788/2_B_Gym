import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
        return const UserProfile();
      }),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://storage.googleapis.com/a1aa/image/r2zxfcEaRKRIQyJ93rkhZOGaF5nkwCef8wobNoQ7cCHDOcJnA.jpg',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Gaspar Rivaldi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Account Number: 043423802',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildProfileItem(
                context,
                icon: FontAwesomeIcons.user,
                title: '@GasparR',
                subtitle: 'Account Name',
              ),
              _buildProfileItem(
                context,
                icon: FontAwesomeIcons.mapMarkerAlt,
                title: 'Lagos, Nigeria',
                subtitle: 'Address',
              ),
              _buildProfileItem(
                context,
                icon: FontAwesomeIcons.phone,
                title: '080********',
                subtitle: 'Phone number',
              ),
              _buildProfileItem(
                context,
                icon: FontAwesomeIcons.envelope,
                title: 'itunu221@gmail.com',
                subtitle: 'Email Address',
              ),
              _buildProfileItem(
                context,
                icon: FontAwesomeIcons.idCard,
                title: 'NIN',
                subtitle: 'Identification Verification',
              ),
              _buildProfileItem(
                context,
                icon: FontAwesomeIcons.userFriends,
                title: 'Father',
                subtitle: 'Next Of Kin',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () async {
        // Navigate to the ProfileDetailScreen and wait for result
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailScreen(
              title: title,
              subtitle: subtitle,
            ),
          ),
        );

        // Check if result contains updated data
        if (result != null) {
          // Handle updated data here
          // For instance, you can refresh the UI or set the new data
          print('Updated Data: ${result['title']}, ${result['subtitle']}');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(icon, color: Colors.blue),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;

  const ProfileDetailScreen({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _subtitleController = TextEditingController(text: widget.subtitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Subtitle',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: 'Subtitle',
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Save or update logic here
                  Navigator.pop(context, {
                    'title': _titleController.text,
                    'subtitle': _subtitleController.text,
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
