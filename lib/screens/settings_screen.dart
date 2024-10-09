import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Custom AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSettingsOption(
              context,
              icon: Icons.person,
              title: 'Account Settings',
              onTap: () {
                // Navigate to Account Settings
              },
            ),
            _buildSettingsOption(
              context,
              icon: Icons.notifications,
              title: 'Notification Settings',
              onTap: () {
                // Navigate to Notification Settings
              },
            ),
            _buildSettingsOption(
              context,
              icon: Icons.privacy_tip,
              title: 'Privacy Settings',
              onTap: () {
                // Navigate to Privacy Settings
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login'); // Log out and redirect
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Use backgroundColor for newer versions of Flutter
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Log Out', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
