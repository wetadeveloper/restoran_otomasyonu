import 'package:flutter/foundation.dart';
import 'package:restoran_otomasyonu/core/services/api_service.dart';

class MasaApi {
  final ApiService _api = ApiService();

  Future<List<dynamic>> getMasalar() async {
    final response = await _api.get('/masalar');
    return response.data;
  }

  Future<Map<String, dynamic>> getMasa(int id) async {
    final response = await _api.get('/masalar/$id');
    return response.data;
  }

  Future<Map<String, dynamic>> createMasa(Map<String, dynamic> data) async {
    final response = await _api.post('/masalar', data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateMasa(int id, Map<String, dynamic> data) async {
    final response = await _api.put('/masalar/$id', data);
    return response.data;
  }

  Future<void> deleteMasa(int id) async {
    await _api.delete('/masalar/$id');
  }

  Future<void> toggleMasaDurum(int id, bool doluMu) async {
    final masa = await getMasa(id);
    final updatedData = {"id": masa["id"], "ad": masa["ad"], "dolu_mu": doluMu ? 1 : 0};
    if (kDebugMode) {
      debugPrint('PUT /masalar/$id with data: $updatedData');
    }
    await _api.put('/masalar/$id', updatedData);
  }
}
