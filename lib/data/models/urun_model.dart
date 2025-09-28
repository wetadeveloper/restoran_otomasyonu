class UrunModel {
  final int id;
  final String ad;
  final double fiyat;
  final String kategori;

  UrunModel({required this.id, required this.ad, required this.fiyat, required this.kategori});

  factory UrunModel.fromJson(Map<String, dynamic> json) {
    return UrunModel(
      id: int.parse(json['id'].toString()),
      ad: json['ad'],
      fiyat: (json['fiyat'] as num).toDouble(),
      kategori: json['kategori'] as String? ?? 'Hatali Kategori',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'ad': ad, 'fiyat': fiyat, 'kategori': kategori};
  }
}
