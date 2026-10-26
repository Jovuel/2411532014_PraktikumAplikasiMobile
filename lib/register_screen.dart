import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';

class RegisterScreen extends StatefulWidget { const RegisterScreen({super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState(); }

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController(); final _email = TextEditingController(); final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      bool success = await DatabaseHelper.instance.registerUser(_name.text, _email.text, _password.text);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Daftar Sukses! Silakan Login')));
        Navigator.pop(context);
      }
    }
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(padding: const EdgeInsets.all(24.0),
        child: Form(key: _formKey,
          child: ListView(children: [
            TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextFormField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: const Text('Daftar'))
          ]),
        ),
      ),
    );
  }
}