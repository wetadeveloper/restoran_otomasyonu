class OdemeModel {
  final int id;
  final int masaId;
  final double toplamTutar;
  final String odemeTipi;
  final DateTime tarih;

  OdemeModel({
    required this.id,
    required this.masaId,
    required this.toplamTutar,
    required this.odemeTipi,
    required this.tarih,
  });

  factory OdemeModel.fromJson(Map<String, dynamic> json) {
    return OdemeModel(
      id: json['id'],
      masaId: json['masaId'],
      toplamTutar: (json['toplamTutar'] as num).toDouble(),
      odemeTipi: json['odemeTipi'],
      tarih: DateTime.parse(json['tarih']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'masaId': masaId,
      'toplamTutar': toplamTutar,
      'odemeTipi': odemeTipi,
      'tarih': tarih.toIso8601String(),
    };
  }
}
