import 'package:restoran_otomasyonu/core/services/api_service.dart';
import 'package:restoran_otomasyonu/data/models/odeme_model.dart';

class OdemeApi {
  final ApiService _api = ApiService();

  Future<List<OdemeModel>> fetchOdemeler() async {
    final response = await _api.get("/odemeler");
    return (response.data as List).map((e) => OdemeModel.fromJson(e)).toList();
  }

  Future<void> addOdeme(OdemeModel odeme) async {
    await _api.post("/odemeler", odeme.toJson());
  }
}
