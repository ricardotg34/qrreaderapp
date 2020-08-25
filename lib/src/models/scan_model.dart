import 'package:latlong/latlong.dart';

class ScanModel {
  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    this.tipo = this.valor.contains('http') ? 'http' : 'geo';
  }

  int id;
  String tipo;
  String valor;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

  LatLng getLatLng(){
    final laLo = valor.substring(4).split(',');
    return LatLng(double.parse(laLo[0]), double.parse(laLo[1]));
  }
}
