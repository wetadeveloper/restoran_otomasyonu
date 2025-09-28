import 'package:restoran_otomasyonu/data/datasources/urun_api.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';

class UrunRepository {
  final UrunApi _api = UrunApi();

  Future<List<UrunModel>> fetchUrunler() => _api.fetchUrunler();

  Future<void> addUrun(UrunModel urun) => _api.addUrun(urun);

  Future<void> deleteUrun(int id) => _api.deleteUrun(id);

  Future<void> updateUrun(UrunModel urun) => _api.updateUrun(urun);
}
