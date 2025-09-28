import 'package:flutter/material.dart';
import 'package:restoran_otomasyonu/data/models/siparis_model.dart';

class SiparisCard extends StatelessWidget {
  final SiparisModel siparis;
  final VoidCallback? onDelete;

  const SiparisCard({super.key, required this.siparis, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text("Masa: ${siparis.masaId}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ürünler ve adetleri
            ...siparis.urunler.map((urun) => Text("• Ürün ID: ${urun.urunId}, Adet: ${urun.adet}")),
            const SizedBox(height: 4),
            Text("Durum: ${siparis.durum}"),
            if (siparis.not != null && siparis.not!.isNotEmpty) Text("Not: ${siparis.not!}"),
          ],
        ),
        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
      ),
    );
  }
}
