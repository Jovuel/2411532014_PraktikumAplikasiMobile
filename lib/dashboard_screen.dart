import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';
import 'detail_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  final Map<String, dynamic>? user;
  const DashboardScreen({super.key, this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isObscure = false;
  List<Map<String, dynamic>> _transactions = [];
  double _totalBalance = 0;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  // Fetch data SQLite dan hitung Saldo Utama
  void _loadTransactions() async {
    final email = widget.user?['email'] ?? '';
    final data = await DatabaseHelper.instance.getTransactions(email);
    
    double balance = 0;
    for (var tx in data) {
      double amount = tx['amount'];
      if (tx['type'] == 'Pemasukan') {
        balance += amount;
      } else {
        balance -= amount;
      }
    }

    if (mounted) {
      setState(() {
        _transactions = data;
        _totalBalance = balance;
      });
    }
  }

  // Fungsi format angka ke Rupiah
  String formatRupiah(double amount) {
    return 'Rp ${amount.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Keuangan'), backgroundColor: Colors.blue),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          // Tunggu form tambah selesai, lalu refresh data
          await Navigator.pushNamed(context, '/add', arguments: widget.user?['email']);
          _loadTransactions(); 
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const CircleAvatar(child: Icon(Icons.person)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo, ${widget.user?['name'] ?? 'User'}!', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Selamat datang kembali', style: TextStyle(color: Colors.grey)),
                ],
              )
            ]),
            const SizedBox(height: 20),
            
            // KARTU SALDO
            Card(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Saldo Utama', style: TextStyle(color: Colors.white70, fontSize: 16)),
                        const SizedBox(height: 8),
                        Text(
                          _isObscure ? "Rp ********" : formatRupiah(_totalBalance),
                          style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.white),
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // TOMBOL AKSI
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBtn(Icons.arrow_downward, 'Masuk', Colors.green),
                _buildBtn(Icons.arrow_upward, 'Keluar', Colors.red),
                _buildBtn(Icons.swap_horiz, 'Transfer', Colors.blue),
              ],
            ),
            const SizedBox(height: 24),
            
            // TRANSAKSI TERAKHIR (Dibatasi 5 terbaru saja di Dashboard)
            const Text("Transaksi Terakhir", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _transactions.isEmpty
                ? const Center(child: Text("Belum ada transaksi"))
                : Column(
                    children: _transactions.take(5).map((tx) {
                      bool isIncome = tx['type'] == 'Pemasukan';
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isIncome ? Colors.green[100] : Colors.red[100],
                            child: Icon(isIncome ? Icons.arrow_downward : Icons.arrow_upward, color: isIncome ? Colors.green : Colors.red),
                          ),
                          title: Text(tx['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(tx['date']),
                          trailing: Text(
                            "${isIncome ? '+' : '-'} ${formatRupiah(tx['amount'])}",
                            style: TextStyle(color: isIncome ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailTransactionScreen(
                                  title: tx['title'],
                                  amount: formatRupiah(tx['amount']),
                                  category: tx['type'],
                                  date: tx['date'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}