import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

// 1. widget utama
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

// 2. halaman utama (scaffold)
class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 1: Widgets'),
        backgroundColor: Colors.blue,
      ),
      // padding untuk memberikan jarak dari tepi layar
      body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(),
              SizedBox(height: 20),
              BalanceCardWidget(),
            ],
          ),
        ),
      );
    }
}

// 3. stateless widget (sapaan pengguna)
class GreetingWidget extends StatelessWidget{
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context){
    return const Row(
      children: [
        // ikon profil
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size:30, color:Colors.white),
        ),
        SizedBox(width:12),
        // teks sapaan
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Budi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Selamat datang kembali!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 4. stateful widget (kartu saldo dengan toggle)
class BalanceCardWidget extends StatefulWidget{
  const BalanceCardWidget({super.key});

  @override
  State<BalanceCardWidget> createState() => _BalanceCardWidgetState();
}

class _BalanceCardWidgetState extends State<BalanceCardWidget>{
  // variabel state : menyimpan status apakah saldo terlihat atau disensor
  bool _isBalanceVisible = true;

  // fungsi untuk mengubah state
  void _toggleVisibility(){
    setState(() {
      _isBalanceVisible = !_isBalanceVisible; // membalik nilai boolean (true <-> false)
    });
  }

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // baris atas kartu: teks "saldo utama" & tombol ikon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saldo Utama',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                // tombol mata
                IconButton(
                  icon: Icon(
                    // logika if-else singkat (ternary operation)
                    _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: _toggleVisibility,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // teks nominal saldo
            Text(
              // logika if-else untuk menampilkan saldo atau sensor
              _isBalanceVisible ? 'Rp5.000.000' : 'Rp *********',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}