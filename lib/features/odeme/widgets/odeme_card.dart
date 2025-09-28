import 'package:flutter/material.dart';
import 'package:restoran_otomasyonu/data/models/odeme_model.dart';
import 'package:restoran_otomasyonu/data/models/siparis_model.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';
import 'package:restoran_otomasyonu/features/odeme/view/odeme_detay_view.dart';

class OdemeCard extends StatelessWidget {
  final OdemeModel odeme;
  final List<SiparisModel> siparisListesi;
  final List<UrunModel> urunListesi;

  const OdemeCard({super.key, required this.odeme, required this.siparisListesi, required this.urunListesi});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.payment),
        title: Text("Masa: ${odeme.masaId}"),
        subtitle: Text("Tutar: ${odeme.toplamTutar.toStringAsFixed(2)} ₺"),
        trailing: Text(odeme.tarih.toLocal().toString().split(' ')[0]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => OdemeDetayView(masaId: odeme.masaId, tumSiparisler: siparisListesi, tumUrunler: urunListesi),
            ),
          );
        },
      ),
    );
  }
}
