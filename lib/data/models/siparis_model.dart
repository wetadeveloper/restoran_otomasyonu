class SiparisModel {
  final String id; // int yerine String
  final int masaId;
  final List<UrunSiparis> urunler;
  final String? not;
  final String durum;
  final DateTime tarih;

  SiparisModel({
    required this.id,
    required this.masaId,
    required this.urunler,
    this.not,
    required this.durum,
    required this.tarih,
  });

  factory SiparisModel.fromJson(Map<String, dynamic> json) {
    return SiparisModel(
      id: json['id'].toString(),
      masaId: json['masaId'] ?? 0,
      urunler: (json['urunler'] as List).map((e) => UrunSiparis.fromJson(e)).toList(),
      not: json['not'],
      durum: json['durum'] ?? '',
      tarih: DateTime.parse(json['tarih'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson({bool forUpdate = false}) {
    final map = {
      'masaId': masaId,
      'urunler': urunler.map((e) => e.toJson()).toList(),
      'not': not,
      'durum': durum,
      'tarih': tarih.toIso8601String(),
    };
    if (forUpdate) {
      map['id'] = id;
    }
    return map;
  }
}

class UrunSiparis {
  final int urunId;
  final int adet;

  UrunSiparis({required this.urunId, required this.adet});

  factory UrunSiparis.fromJson(Map<String, dynamic> json) {
    return UrunSiparis(urunId: json['urunId'] ?? 0, adet: json['adet'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'urunId': urunId, 'adet': adet};
  }
}
