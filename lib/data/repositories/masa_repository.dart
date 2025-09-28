import 'package:restoran_otomasyonu/data/datasources/masa_api.dart';
import 'package:restoran_otomasyonu/data/models/masa_model.dart';

class MasaRepository {
  final MasaApi _api = MasaApi();

  Future<List<MasaModel>> fetchMasalar() async {
    final data = await _api.getMasalar();
    return data.map((json) => MasaModel.fromJson(json)).toList();
  }

  Future<MasaModel> fetchMasa(int id) async {
    final data = await _api.getMasa(id);
    return MasaModel.fromJson(data);
  }

  Future<MasaModel> addMasa(MasaModel masa) async {
    final data = await _api.createMasa(masa.toJson());
    return MasaModel.fromJson(data);
  }

  Future<MasaModel> updateMasa(MasaModel masa) async {
    final data = await _api.updateMasa(masa.id, masa.toJson());
    return MasaModel.fromJson(data);
  }

  Future<void> deleteMasa(int id) async {
    await _api.deleteMasa(id);
  }

  Future<void> toggleMasaDurum(int id, bool doluMu) async {
    await _api.toggleMasaDurum(id, doluMu);
  }
}
