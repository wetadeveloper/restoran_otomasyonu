import 'package:flutter/foundation.dart';
import 'package:restoran_otomasyonu/core/base/base_view_model.dart';
import 'package:restoran_otomasyonu/data/models/siparis_model.dart';
import 'package:restoran_otomasyonu/data/repositories/siparis_repository.dart';

class SiparislerViewModel extends BaseViewModel {
  final SiparisRepository _repository = SiparisRepository();
  List<SiparisModel> _siparisler = [];

  List<SiparisModel> get siparisler => _siparisler;

  Future<void> getSiparisler() async {
    try {
      setLoading(true);
      _siparisler = await _repository.fetchSiparisler();
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Siparişler alınamadı: $e");
        setError("Siparişler alınamadı: $e");
      }
    } finally {
      setLoading(false);
    }
  }

  Map<int, List<SiparisModel>> get siparislerGruplanmis {
    final Map<int, List<SiparisModel>> grup = {};
    for (var siparis in _siparisler) {
      grup.putIfAbsent(siparis.masaId, () => []);
      grup[siparis.masaId]!.add(siparis);
    }

    return grup;
  }

  Future<void> silSiparis(int id) async {
    try {
      await _repository.deleteSiparis(id);
      _siparisler.removeWhere((siparis) => siparis.id == id);
      notifyListeners();
    } catch (e) {
      setError("Sipariş silinemedi: $e");
    }
  }
}
