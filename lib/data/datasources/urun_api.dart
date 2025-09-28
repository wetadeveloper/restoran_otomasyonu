import 'package:restoran_otomasyonu/core/services/api_service.dart';
import 'package:restoran_otomasyonu/data/models/urun_model.dart';

class UrunApi {
  final ApiService _api = ApiService();

  Future<List<UrunModel>> fetchUrunler() async {
    final response = await _api.get('/urunler');
    final data = response.data;
    if (data is List) {
      return data.map((e) => UrunModel.fromJson(e)).toList();
    } else {
      throw Exception("Beklenen liste formatında veri gelmedi");
    }
  }

  Future<void> addUrun(UrunModel urun) async {
    await _api.post('/urunler', urun.toJson()); // ✅ doğru
  }

  Future<void> deleteUrun(int urunId) async {
    await _api.delete('/urunler/$urunId');
  }

  // opsiyonel güncelleme:
  Future<void> updateUrun(UrunModel urun) async {
    await _api.put('/urunler/${urun.id}', urun.toJson());
  }
}
