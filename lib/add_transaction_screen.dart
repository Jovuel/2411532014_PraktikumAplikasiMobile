import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';

class AddTransactionScreen extends StatefulWidget { const AddTransactionScreen({super.key});
  @override State<AddTransactionScreen> createState() => _AddTransactionScreenState(); }

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _title = TextEditingController(); final _amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _type = 'Pengeluaran';

  void _save(String email) async {
    if (_formKey.currentState!.validate()) {
      await DatabaseHelper.instance.insertTransaction({
        'user_email': email, 'title': _title.text, 'amount': double.parse(_amount.text),
        'type': _type, 'date': DateTime.now().toString().split(' ')[0],
      });
      if (mounted) Navigator.pop(context); // Kembali ke Dashboard otomatis
    }
  }
  @override Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: Form(key: _formKey,
          child: Column(children: [
            TextFormField(controller: _title, decoration: const InputDecoration(labelText: "Judul"), validator: (val) => val!.isEmpty ? "Wajib diisi" : null),
            const SizedBox(height: 16),
            TextFormField(controller: _amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Nominal (Rp)"), validator: (val) => val!.isEmpty ? "Wajib diisi" : null),
            const SizedBox(height: 16),
            DropdownButtonFormField(value: _type, items: ['Pengeluaran', 'Pemasukan'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (val) => setState(() => _type = val as String)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => _save(email), child: const Text("Simpan Transaksi"))
          ]),
        ),
      ),
    );
  }
}