import 'package:restoran_otomasyonu/core/base/base_view_model.dart';
import 'package:restoran_otomasyonu/data/models/masa_model.dart';
import 'package:restoran_otomasyonu/data/repositories/masa_repository.dart';

class MasalarViewModel extends BaseViewModel {
  final MasaRepository _repository = MasaRepository();

  List<MasaModel> _masalar = [];

  List<MasaModel> get masalar => _masalar;

  Future<void> fetchMasalar() async {
    try {
      setLoading(true);
      _masalar = await _repository.fetchMasalar();
    } catch (e) {
      print("Masalar yüklenirken hata oluştu: $e");
      setError("Masalar yüklenemedi: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> toggleMasaDurum(int masaId) async {
    try {
      final masa = _masalar.firstWhere((m) => m.id == masaId);
      final updated = masa.copyWith(doluMu: !masa.doluMu);
      await _repository.updateMasa(updated);
      await fetchMasalar(); // yeniden listeyi çek
    } catch (e) {
      print("Masa durumu güncellenirken hata oluştu: $e");
      setError("Masa güncellenemedi: $e");
    }
  }
}
