import 'package:flutter/material.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';

class UrunCard extends StatelessWidget {
  final UrunModel urun;
  final VoidCallback? onDelete;

  const UrunCard({super.key, required this.urun, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(urun.ad),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Fiyat: ${urun.fiyat.toStringAsFixed(2)} ₺"), Text("Kategori: ${urun.kategori}")],
        ),
        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
      ),
    );
  }
}
