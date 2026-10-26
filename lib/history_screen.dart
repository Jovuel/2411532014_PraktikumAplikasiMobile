import 'package:flutter/material.dart';
import 'helpers/database_helper.dart';
import 'detail_transaction_screen.dart';

class HistoryScreen extends StatefulWidget {
  final String userEmail;
  const HistoryScreen({super.key, required this.userEmail});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadAllTransactions();
  }

  void _loadAllTransactions() async {
    final data = await DatabaseHelper.instance.getTransactions(widget.userEmail);
    if (mounted) {
      setState(() {
        _transactions = data;
      });
    }
  }

  String formatRupiah(double amount) {
    return 'Rp ${amount.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semua Riwayat'), backgroundColor: Colors.blue),
      body: _transactions.isEmpty
          ? const Center(child: Text("Belum ada riwayat transaksi."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final tx = _transactions[index];
                bool isIncome = tx['type'] == 'Pemasukan';
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
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
              },
            ),
    );
  }
}