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
        title: const Text('Praktikum 2: Layouting'),
        backgroundColor: Colors.blue,
      ),
      // padding untuk memberikan jarak dari tepi layar
      body:const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(),
              SizedBox(height: 20),
              BalanceCardWidget(),
              SizedBox(height: 20),
              ActionButtonsWidget(),
              SizedBox(height: 20),
              RecentTransactionWidget(),
            ],
          ),
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

// 5. widget tombol aksi (row)
class ActionButtonsWidget extends StatelessWidget{
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context){
    // menggunakan row untuk menata tombol secara horizontal
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.arrow_downward, 'Pemasukan', Colors.green),
        _buildActionButton(Icons.arrow_upward, 'Pengeluaran', Colors.red),
        _buildActionButton(Icons.swap_horiz, 'Transfer', Colors.blue),
      ],
    );
  }
  // fungsi pembantu untuk membuat desain tombol agar kode tidak berulang
  Widget _buildActionButton(IconData icon, String label, Color color){
    return Column(
      children: [
        // container untuk membungkus ikon dengan warna background
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// 6. widget daftar transaksi (column & listtile)
class RecentTransactionWidget extends StatelessWidget{
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaksi Terakhir',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // menggunakan card agar daftar transaksi memiliki bayangan/bingkai
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              // item transaksi 1
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.fastfood, color: Colors.white),
                ),
                title: const Text('Makan Siang'),
                subtitle: const Text('13 Sep 2026'), // tanggal statis
                trailing: const Text(
                  '- Rp50.000',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),

              // item transaksi 2
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.attach_money, color: Colors.white),
                ),
                title: const Text('Gaji Bulanan'),
                subtitle: const Text('01 Sep 2026'),
                trailing: const Text(
                  '+ Rp5.000.000',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              
              // item transaksi 3
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.directions_car, color: Colors.white),
                ),
                title: const Text('Isi Bensin'),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp150.000',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}