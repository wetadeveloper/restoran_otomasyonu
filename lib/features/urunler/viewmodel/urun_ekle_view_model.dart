import 'package:flutter/material.dart';
import 'package:restoran_otomasyonu/core/base/base_view_model.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';
import 'package:restoran_otomasyonu/data/repositories/urun_repository.dart';

class UrunEkleViewModel extends BaseViewModel {
  final UrunRepository _repository = UrunRepository();

  String ad = '';
  double fiyat = 0.0;
  List<String> kategoriler = ['Yemek', 'İçecek', 'Tatlı'];
  String? secilenKategori;

  Future<void> urunEkle(BuildContext context) async {
    if (ad.isEmpty || fiyat <= 0 || secilenKategori == null) {
      setError("Geçerli bir ad, fiyat ve kategori seçilmelidir.");
      return;
    }

    final yeniUrun = UrunModel(id: 0, ad: ad, fiyat: fiyat, kategori: secilenKategori ?? 'Hatali Kategori');

    try {
      setLoading(true);
      await _repository.addUrun(yeniUrun);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ürün başarıyla eklendi!")));
        Navigator.pop(context);
      }
    } catch (e) {
      setError("Ürün eklenemedi: $e");
    } finally {
      setLoading(false);
    }
  }
}
