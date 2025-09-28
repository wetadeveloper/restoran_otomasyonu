import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/core/constants/app_strings.dart';
import 'package:restoran_otomasyonu/features/urunler/viewmodel/urun_ekle_view_model.dart';

class UrunEkleView extends StatelessWidget {
  const UrunEkleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UrunEkleViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.urunEkle)),
        body: Consumer<UrunEkleViewModel>(
          builder: (context, viewModel, _) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Ürün Adı"),
                    onChanged: (value) => viewModel.ad = value,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(labelText: "Fiyat (₺)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => viewModel.fiyat = double.tryParse(value) ?? 0,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Kategori"),
                    value: viewModel.secilenKategori,
                    items:
                        viewModel.kategoriler
                            .map((kategori) => DropdownMenuItem(value: kategori, child: Text(kategori)))
                            .toList(),
                    onChanged: (value) {
                      viewModel.secilenKategori = value;
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: viewModel.isLoading ? null : () => viewModel.urunEkle(context),
                    child: viewModel.isLoading ? const CircularProgressIndicator() : const Text("Ekle"),
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
