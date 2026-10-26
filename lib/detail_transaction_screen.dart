import 'package:flutter/material.dart';

class DetailTransactionScreen extends StatelessWidget {
  final String title; final String amount; final String category; final String date;
  const DetailTransactionScreen({super.key, required this.title, required this.amount, required this.category, required this.date});

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Transaksi")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.receipt_long, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Rp $amount", style: const TextStyle(fontSize: 20, color: Colors.red)),
          const SizedBox(height: 20),
          Text("Kategori: $category", style: const TextStyle(fontSize: 16)),
          Text("Tanggal: $date", style: const TextStyle(fontSize: 16)),
        ]),
      ),
    );
  }
}