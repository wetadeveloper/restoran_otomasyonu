import 'package:restoran_otomasyonu/data/datasources/siparis_api.dart';
import 'package:restoran_otomasyonu/data/models/siparis_model.dart';

class SiparisRepository {
  final SiparisApi _api = SiparisApi();

  Future<List<SiparisModel>> fetchSiparisler() async {
    final data = await _api.getSiparisler();
    return data.map((json) => SiparisModel.fromJson(json)).toList();
  }

  Future<SiparisModel> fetchSiparis(int id) async {
    final data = await _api.getSiparis(id);
    return SiparisModel.fromJson(data);
  }

  Future<SiparisModel> addSiparis(SiparisModel siparis) async {
    final data = await _api.createSiparis(siparis.toJson());
    return SiparisModel.fromJson(data);
  }

  Future<SiparisModel> updateSiparis(SiparisModel siparis) async {
    final data = await _api.updateSiparis(int.parse(siparis.id), siparis.toJson(forUpdate: true));
    return SiparisModel.fromJson(data);
  }

  Future<void> deleteSiparis(int id) async {
    await _api.deleteSiparis(id);
  }
}
