import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/core/constants/app_strings.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';
import 'package:restoran_otomasyonu/features/siparisler/viewmodel/siparis_ekle_view_model.dart';

class SiparisEkleView extends StatelessWidget {
  const SiparisEkleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SiparisEkleViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.siparisEkle)),
        body: Consumer<SiparisEkleViewModel>(
          builder: (context, viewModel, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Masa seçimi
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: "Masa ID"),
                    value: viewModel.masaId,
                    onChanged: (value) {
                      viewModel.masaId = value;
                    },
                    items:
                        List.generate(
                          10,
                          (index) => index + 1,
                        ).map((id) => DropdownMenuItem(value: id, child: Text("Masa $id"))).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Kategori seçimi
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Kategori"),
                    value: viewModel.secilenKategori,
                    onChanged: (value) => viewModel.kategoriSec(value),
                    items: viewModel.kategoriler.map((k) => DropdownMenuItem(value: k, child: Text(k))).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Ürün seçimi ve adet
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<UrunModel>(
                          decoration: const InputDecoration(labelText: "Ürün"),
                          value: viewModel.secilenUrun,
                          onChanged: (urun) => viewModel.urunSec(urun),
                          items:
                              viewModel.filtrelenmisUrunler
                                  .map((urun) => DropdownMenuItem(value: urun, child: Text(urun.ad)))
                                  .toList(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: "Adet"),
                          initialValue: viewModel.adet.toString(),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => viewModel.setAdet(int.tryParse(value) ?? 1),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: viewModel.urunEkle,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Seçilen ürünler listesi
                  if (viewModel.seciliUrunler.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.seciliUrunler.length,
                        itemBuilder: (context, index) {
                          final urunSiparis = viewModel.seciliUrunler[index];
                          final urun = viewModel.urunler.firstWhere(
                            (u) => u.id == urunSiparis.urunId,
                            orElse: () => UrunModel(id: 0, ad: "Bilinmeyen Ürün", fiyat: 0, kategori: ""),
                          );

                          return ListTile(
                            title: Text(urun.ad),
                            subtitle: Text("Adet: ${urunSiparis.adet}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => viewModel.urunSil(index),
                            ),
                          );
                        },
                      ),
                    ),

                  // Not alanı
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Not"),
                    onChanged: (value) {
                      viewModel.not = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Siparişi Gönder butonu
                  ElevatedButton(
                    onPressed: viewModel.isLoading ? null : () => viewModel.siparisOlustur(context),
                    child:
                        viewModel.isLoading
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text("Siparişi Gönder"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
