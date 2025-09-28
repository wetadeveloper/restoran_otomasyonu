import 'package:restoran_otomasyonu/core/base/base_view_model.dart';
import 'package:restoran_otomasyonu/data/models/odeme_model.dart';
import 'package:restoran_otomasyonu/data/repositories/odeme_repository.dart';

class OdemeViewModel extends BaseViewModel {
  final OdemeRepository _repository = OdemeRepository();

  List<OdemeModel> odemeler = [];

  Future<void> fetchOdemeler() async {
    setLoading(true);
    clearError();
    try {
      odemeler = await _repository.getAllOdemeler();
    } catch (e) {
      print('Ödeme yükleme hatası: $e');
      setError("Ödemeler yüklenirken hata oluştu: $e");
    }
    setLoading(false);
  }

  Future<void> addOdeme(OdemeModel odeme) async {
    setLoading(true);
    clearError();
    try {
      await _repository.addOdeme(odeme);
      odemeler.add(odeme); // başarılı eklemeyse listeyi güncelle
    } catch (e) {
      print("Error adding payment: $e");
      setError("Ödeme eklenirken hata oluştu: $e");
    }
    setLoading(false);
  }
}
