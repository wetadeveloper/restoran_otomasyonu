import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/core/constants/app_colors.dart';
import 'package:restoran_otomasyonu/core/constants/app_strings.dart';
import 'package:restoran_otomasyonu/features/odeme/widgets/odeme_card.dart';
import 'package:restoran_otomasyonu/features/siparisler/viewmodel/siparisler_view_model.dart';
import 'package:restoran_otomasyonu/features/urunler/viewmodel/urunler_view_model.dart';
import 'package:restoran_otomasyonu/data/models/odeme_model.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';

class OdemeView extends StatefulWidget {
  const OdemeView({super.key});

  @override
  State<OdemeView> createState() => _OdemeViewState();
}

class _OdemeViewState extends State<OdemeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        final siparisViewModel = context.read<SiparislerViewModel>();
        final urunViewModel = context.read<UrunlerViewModel>();

        await siparisViewModel.getSiparisler();
        await urunViewModel.fetchUrunler();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final siparisViewModel = context.watch<SiparislerViewModel>();
    final urunListesi = context.watch<UrunlerViewModel>().urunler;

    if (siparisViewModel.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (siparisViewModel.errorMessage != null) {
      return Scaffold(body: Center(child: Text(siparisViewModel.errorMessage!)));
    }

    final siparisGruplanmis = siparisViewModel.siparislerGruplanmis;
    final masaIdListesi = siparisGruplanmis.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.odeme, style: TextStyle(color: AppColors.title, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.icon),
      ),
      body: ListView.builder(
        itemCount: masaIdListesi.length,
        itemBuilder: (context, index) {
          final masaId = masaIdListesi[index];
          final masaSiparisleri = siparisGruplanmis[masaId] ?? [];

          double toplamTutar = 0;
          for (var siparis in masaSiparisleri) {
            for (var sipUrun in siparis.urunler) {
              final urun = urunListesi.firstWhere(
                (u) => u.id == sipUrun.urunId,
                orElse: () => UrunModel(id: 0, ad: 'Bilinmeyen', fiyat: 0, kategori: 'Bilinmeyen'),
              );
              toplamTutar += urun.fiyat * sipUrun.adet;
            }
          }

          final fakeOdeme = OdemeModel(
            id: 0,
            masaId: masaId,
            toplamTutar: toplamTutar,
            odemeTipi: '',
            tarih: DateTime.now(),
          );

          return OdemeCard(odeme: fakeOdeme, siparisListesi: masaSiparisleri, urunListesi: urunListesi);
        },
      ),
    );
  }
}
