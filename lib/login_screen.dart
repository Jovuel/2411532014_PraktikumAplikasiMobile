import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';

class LoginScreen extends StatefulWidget { const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState(); }

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(); final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final user = await DatabaseHelper.instance.loginUser(_email.text, _password.text);
      if (user != null && mounted) {
        Navigator.pushReplacementNamed(context, '/main', arguments: user);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Gagal')));
      }
    }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(24.0),
        child: Form(key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()), validator: (val) => val!.isEmpty ? 'Isi email' : null),
            const SizedBox(height: 16),
            TextFormField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()), validator: (val) => val!.isEmpty ? 'Isi password' : null),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: const Text('Daftar Akun Baru'))
          ]),
        ),
      ),
    );
  }
}