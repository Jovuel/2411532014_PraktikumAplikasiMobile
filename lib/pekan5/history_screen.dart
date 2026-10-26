import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> historyItems = [
      {
        'title': 'Makan Siang',
        'date': '26 Okt 2026',
        'amount': '- Rp 50.000',
        'isExpense': true,
        'icon': Icons.restaurant
      },
      {
        'title': 'Gaji Bulanan',
        'date': '25 Okt 2026',
        'amount': '+ Rp 5.000.000',
        'isExpense': false,
        'icon': Icons.work
      },
      {
        'title': 'Belanja Bulanan',
        'date': '24 Okt 2026',
        'amount': '- Rp 350.000',
        'isExpense': true,
        'icon': Icons.shopping_cart
      },
      {
        'title': 'Beli Kopi',
        'date': '23 Okt 2026',
        'amount': '- Rp 25.000',
        'isExpense': true,
        'icon': Icons.local_cafe
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    item['isExpense'] ? Colors.red[100] : Colors.green[100],
                child: Icon(
                  item['icon'] as IconData,
                  color: item['isExpense'] ? Colors.red : Colors.green,
                ),
              ),
              title: Text(
                item['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['date'] as String),
              trailing: Text(
                item['amount'] as String,
                style: TextStyle(
                  color: item['isExpense'] ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}