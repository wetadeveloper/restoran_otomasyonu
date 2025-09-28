import 'package:flutter/material.dart';
import 'package:restoran_otomasyonu/core/base/base_view_model.dart';
import 'package:restoran_otomasyonu/data/models/siparis_model.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';
import 'package:restoran_otomasyonu/data/repositories/masa_repository.dart';
import 'package:restoran_otomasyonu/data/repositories/siparis_repository.dart';
import 'package:restoran_otomasyonu/data/repositories/urun_repository.dart';

class SiparisEkleViewModel extends BaseViewModel {
  final SiparisRepository _repository = SiparisRepository();
  final UrunRepository _urunRepository = UrunRepository();
  final MasaRepository _masaRepository = MasaRepository();

  int? _masaId;
  int _adet = 1;
  String? _not;
  List<UrunSiparis> seciliUrunler = [];
  List<UrunModel> urunler = [];

  // Yeni alanlar
  List<String> kategoriler = [];
  String? secilenKategori;
  List<UrunModel> filtrelenmisUrunler = [];

  UrunModel? secilenUrun;

  int? get masaId => _masaId;
  set masaId(int? value) {
    _masaId = value;
    notifyListeners();
  }

  int get adet => _adet;
  void setAdet(int value) {
    _adet = value;
    notifyListeners();
  }

  String? get not => _not;
  set not(String? value) {
    _not = value;
    notifyListeners();
  }

  SiparisEkleViewModel() {
    fetchUrunler();
  }

  Future<void> fetchUrunler() async {
    try {
      setLoading(true);
      urunler = await _urunRepository.fetchUrunler();

      // Kategorileri çıkar
      final kategoriSet = urunler.map((u) => u.kategori).toSet();
      kategoriler = kategoriSet.toList();

      if (kategoriler.isNotEmpty) {
        secilenKategori = kategoriler.first;
        filtreleUrunler();
      }
    } catch (e) {
      setError("Ürünler alınamadı: $e");
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void kategoriSec(String? kategori) {
    secilenKategori = kategori;
    filtreleUrunler();
    // Ürün seçimini sıfırla
    secilenUrun = null;
    notifyListeners();
  }

  void filtreleUrunler() {
    if (secilenKategori == null) {
      filtrelenmisUrunler = [];
    } else {
      filtrelenmisUrunler = urunler.where((u) => u.kategori == secilenKategori).toList();
    }
  }

  void urunSec(UrunModel? urun) {
    secilenUrun = urun;
    notifyListeners();
  }

  void urunEkle() {
    if (secilenUrun == null || adet <= 0) return;

    final mevcut = seciliUrunler.indexWhere((e) => e.urunId == secilenUrun!.id);
    if (mevcut != -1) {
      seciliUrunler[mevcut] = UrunSiparis(urunId: secilenUrun!.id, adet: seciliUrunler[mevcut].adet + adet);
    } else {
      seciliUrunler.add(UrunSiparis(urunId: secilenUrun!.id, adet: adet));
    }
    notifyListeners();
  }

  void urunSil(int index) {
    seciliUrunler.removeAt(index);
    notifyListeners();
  }

  Future<void> siparisOlustur(BuildContext context) async {
    if (masaId == null) {
      setError("Masa seçilmelidir.");
      return;
    }

    // "+" butonuna basılmasa bile, seçili ürün ve adet varsa listeye ekle
    if (secilenUrun != null && adet > 0) {
      final mevcut = seciliUrunler.indexWhere((e) => e.urunId == secilenUrun!.id);
      if (mevcut != -1) {
        seciliUrunler[mevcut] = UrunSiparis(urunId: secilenUrun!.id, adet: seciliUrunler[mevcut].adet + adet);
      } else {
        seciliUrunler.add(UrunSiparis(urunId: secilenUrun!.id, adet: adet));
      }
    }

    if (seciliUrunler.isEmpty) {
      setError("En az bir ürün seçilmelidir.");
      return;
    }

    final yeniSiparis = SiparisModel(
      id: "1",
      masaId: masaId!,
      urunler: seciliUrunler,
      not: not,
      durum: "hazırlanıyor",
      tarih: DateTime.now(),
    );

    debugPrint("Sipariş gönderiliyor: ${yeniSiparis.toJson()}");

    try {
      setLoading(true);
      await _repository.addSiparis(yeniSiparis);
      await _masaRepository.toggleMasaDurum(masaId!, true);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Sipariş başarıyla eklendi ve masa dolu olarak işaretlendi!")));
        Navigator.pop(context);
      }
    } catch (e, stack) {
      debugPrint("Sipariş eklenirken hata: $e");
      debugPrint(stack.toString());
      setError("Sipariş eklenemedi: $e");
    } finally {
      setLoading(false);
    }
  }
}
