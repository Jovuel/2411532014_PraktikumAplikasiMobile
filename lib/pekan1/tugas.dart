import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Kabataku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _nilai1Controller = TextEditingController();
  final TextEditingController _nilai2Controller = TextEditingController();

  String _hasil = 'Hasil: -';

  void _tambah() {
    double? nilai1 = double.tryParse(_nilai1Controller.text);
    double? nilai2 = double.tryParse(_nilai2Controller.text);

    if (nilai1 == null || nilai2 == null) {
      setState(() {
        _hasil = 'Hasil: Masukkan angka yang valid';
      });
      return;
    }

    double hasil = nilai1 + nilai2;

    setState(() {
      _hasil = 'Hasil: $hasil';
    });
  }

  void _kurang() {
    double? nilai1 = double.tryParse(_nilai1Controller.text);
    double? nilai2 = double.tryParse(_nilai2Controller.text);

    if (nilai1 == null || nilai2 == null) {
      setState(() {
        _hasil = 'Hasil: Masukkan angka yang valid';
      });
      return;
    }

    double hasil = nilai1 - nilai2;

    setState(() {
      _hasil = 'Hasil: $hasil';
    });
  }

  void _kali() {
    double? nilai1 = double.tryParse(_nilai1Controller.text);
    double? nilai2 = double.tryParse(_nilai2Controller.text);

    if (nilai1 == null || nilai2 == null) {
      setState(() {
        _hasil = 'Hasil: Masukkan angka yang valid';
      });
      return;
    }

    double hasil = nilai1 * nilai2;

    setState(() {
      _hasil = 'Hasil: $hasil';
    });
  }

  void _bagi() {
    double? nilai1 = double.tryParse(_nilai1Controller.text);
    double? nilai2 = double.tryParse(_nilai2Controller.text);

    if (nilai1 == null || nilai2 == null) {
      setState(() {
        _hasil = 'Hasil: Masukkan angka yang valid';
      });
      return;
    }

    if (nilai2 == 0) {
      setState(() {
        _hasil = 'Hasil: Tidak dapat dibagi dengan 0';
      });
      return;
    }

    double hasil = nilai1 / nilai2;

    setState(() {
      _hasil = 'Hasil: $hasil';
    });
  }

  @override
  void dispose() {
    _nilai1Controller.dispose();
    _nilai2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Kabataku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nilai1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nilai Pertama',
                hintText: 'Masukkan nilai pertama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _nilai2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nilai Kedua',
                hintText: 'Masukkan nilai kedua',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _tambah,
                    child: const Text('+ Tambah'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _kurang,
                    child: const Text('- Kurang'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _kali,
                    child: const Text('× Kali'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _bagi,
                    child: const Text('÷ Bagi'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              _hasil,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}