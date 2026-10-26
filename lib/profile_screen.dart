import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? user;
  const ProfileScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    String name = user?['name'] ?? 'User';
    String email = user?['email'] ?? 'email@domain.com';

    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(radius: 60, backgroundColor: Colors.blueAccent, child: Icon(Icons.person, size: 70, color: Colors.white)),
            const SizedBox(height: 24),
            Text(name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Logout Keluar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () {
                  // Hapus semua rute sebelumnya dan kembali ke halaman Login
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}