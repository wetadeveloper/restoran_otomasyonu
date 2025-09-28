import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/data/models/siparis_model.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';
import 'package:restoran_otomasyonu/features/odeme/viewmodel/odeme_detay_view_model.dart';

class OdemeDetayView extends StatelessWidget {
  final int masaId;
  final List<SiparisModel> tumSiparisler;
  final List<UrunModel> tumUrunler;

  const OdemeDetayView({super.key, required this.masaId, required this.tumSiparisler, required this.tumUrunler});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OdemeDetayViewModel(masaId: masaId, tumSiparisler: tumSiparisler, tumUrunler: tumUrunler),
      child: Consumer<OdemeDetayViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(title: Text("Masa $masaId Sipariş Detayı")),
            body:
                model.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: model.siparisler.length,
                      itemBuilder: (context, index) {
                        final siparis = model.siparisler[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  siparis.urunler.map((urun) {
                                    final urunAdi = model.getUrunAdi(urun.urunId);
                                    final fiyat = model.getUrunFiyati(urun.urunId);
                                    return Text("$urunAdi x${urun.adet} - ${urun.adet * fiyat}₺");
                                  }).toList(),
                            ),
                            subtitle: Text("Tarih: ${siparis.tarih}"),
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
