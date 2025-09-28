import 'package:restoran_otomasyonu/core/services/api_service.dart';

class SiparisApi {
  final ApiService _api = ApiService();

  Future<List<dynamic>> getSiparisler() async {
    final response = await _api.get('/siparisler');
    return response.data;
  }

  Future<Map<String, dynamic>> getSiparis(int id) async {
    final response = await _api.get('/siparisler/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> createSiparis(Map<String, dynamic> data) async {
    final response = await _api.post('/siparisler', data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateSiparis(int id, Map<String, dynamic> data) async {
    final response = await _api.put('/siparisler/$id', data);
    return response.data;
  }

  Future<void> deleteSiparis(int id) async {
    await _api.delete('/siparisler/$id');
  }
}
