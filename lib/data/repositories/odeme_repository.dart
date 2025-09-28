import 'package:restoran_otomasyonu/data/datasources/odeme_api.dart';
import 'package:restoran_otomasyonu/data/models/odeme_model.dart';

class OdemeRepository {
  final OdemeApi _api = OdemeApi();

  Future<List<OdemeModel>> getAllOdemeler() => _api.fetchOdemeler();
  Future<void> addOdeme(OdemeModel odeme) => _api.addOdeme(odeme);
}
