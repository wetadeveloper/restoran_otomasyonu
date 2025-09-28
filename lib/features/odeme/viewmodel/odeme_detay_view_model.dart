import 'package:restoran_otomasyonu/core/base/base_view_model.dart';
import 'package:restoran_otomasyonu/data/models/siparis_model.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';

class OdemeDetayViewModel extends BaseViewModel {
  final int masaId;
  final List<SiparisModel> tumSiparisler;
  final List<UrunModel> tumUrunler;

  List<SiparisModel> siparisler = [];

  OdemeDetayViewModel({required this.masaId, required this.tumSiparisler, required this.tumUrunler}) {
    _loadDetaylar();
  }

  void _loadDetaylar() {
    setLoading(true);
    try {
      // Bu masaya ait tüm siparişleri filtrele
      siparisler = tumSiparisler.where((s) => s.masaId == masaId).toList();
    } catch (e) {
      setError("Detaylar yüklenirken hata oluştu: $e");
    }
    setLoading(false);
  }

  String getUrunAdi(int urunId) {
    return tumUrunler.firstWhere((e) => e.id == urunId).ad;
  }

  double getUrunFiyati(int urunId) {
    return tumUrunler.firstWhere((e) => e.id == urunId).fiyat;
  }
}
