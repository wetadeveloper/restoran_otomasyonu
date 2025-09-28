import 'package:flutter/foundation.dart';
import 'package:restoran_otomasyonu/core/base/base_view_model.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';
import 'package:restoran_otomasyonu/data/repositories/urun_repository.dart';

class UrunlerViewModel extends BaseViewModel {
  final UrunRepository _repository = UrunRepository();
  List<UrunModel> _urunler = [];

  List<UrunModel> get urunler => _urunler;

  Future<void> fetchUrunler() async {
    try {
      setLoading(true);
      _urunler = await _repository.fetchUrunler();
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Ürünler alınamadı: $e");
        setError("Ürünler alınamadı: $e");
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteUrun(int urunId) async {
    try {
      await _repository.deleteUrun(urunId);
      _urunler.removeWhere((urun) => urun.id == urunId);
      notifyListeners();
    } catch (e) {
      setError("Ürün silinemedi: $e");
    }
  }
}
