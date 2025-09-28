import 'package:flutter/material.dart';
import 'package:restoran_otomasyonu/data/models/masa_model.dart';

class MasaCard extends StatelessWidget {
  final MasaModel masa;
  final VoidCallback? onTap;

  const MasaCard({super.key, required this.masa, this.onTap});

  @override
  Widget build(BuildContext context) {
    final renk = masa.doluMu ? Colors.red[300] : Colors.green[300];
    final durum = masa.doluMu ? "DOLU" : "BOŞ";

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: renk,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Masa ${masa.id}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(durum, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
