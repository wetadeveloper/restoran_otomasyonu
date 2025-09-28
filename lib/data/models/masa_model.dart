class MasaModel {
  final int id;
  final String ad;
  final bool doluMu;

  MasaModel({required this.id, required this.ad, required this.doluMu});

  factory MasaModel.fromJson(Map<String, dynamic> json) {
    return MasaModel(id: int.parse(json['id'].toString()), ad: json['ad'], doluMu: json['dolu_mu'] == 1);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'ad': ad, 'dolu_mu': doluMu ? 1 : 0};
  }

  MasaModel copyWith({int? id, String? ad, bool? doluMu}) {
    return MasaModel(id: id ?? this.id, ad: ad ?? this.ad, doluMu: doluMu ?? this.doluMu);
  }
}
