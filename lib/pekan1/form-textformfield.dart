import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Basic Form TextFormField"),
        ),
        // Tambahan: Memberi jarak agar form tidak menempel ke pinggir layar
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: MyFormText(),
        ),
      ),
    );
  }
}

class MyFormText extends StatefulWidget {
  const MyFormText({super.key});

  @override
  State<MyFormText> createState() => _MyFormTextState();
}

class _MyFormTextState extends State<MyFormText> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Validasi $name, $email Berhasil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN UTAMA: Column dibungkus dengan widget Form dan diberi _formKey
    return Form(
      key: _formKey, 
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Nama : ", 
              border: OutlineInputBorder()
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan nama anda';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email : ", 
              border: OutlineInputBorder()
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan email anda';
              }
              if (!value.contains('@')) {
                return 'Email tidak valid';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm, 
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}