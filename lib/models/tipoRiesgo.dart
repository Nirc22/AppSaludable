// To parse this JSON data, do
//
//     final tipoRiesgo = tipoRiesgoFromJson(jsonString);

import 'dart:convert';

TipoRiesgo tipoRiesgoFromJson(String str) =>
    TipoRiesgo.fromJson(json.decode(str));

String tipoRiesgoToJson(TipoRiesgo data) => json.encode(data.toJson());

class TipoRiesgo {
  TipoRiesgo({
    required this.id,
    required this.nombre,
    required this.recomendaciones,
    required this.v,
    required this.rangoMaximo,
    required this.rangoMinimo,
  });

  String id;
  String nombre;
  List<dynamic> recomendaciones;
  int v;
  double rangoMaximo;
  double rangoMinimo;

  factory TipoRiesgo.fromJson(Map<String, dynamic> json) => TipoRiesgo(
        id: json["_id"],
        nombre: json["nombre"],
        recomendaciones:
            List<dynamic>.from(json["recomendaciones"].map((x) => x)),
        v: json["__v"],
        rangoMaximo: json["rangoMaximo"].toDouble(),
        rangoMinimo: json["rangoMinimo"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "recomendaciones": List<dynamic>.from(recomendaciones.map((x) => x)),
        "__v": v,
        "rangoMaximo": rangoMaximo,
        "rangoMinimo": rangoMinimo,
      };
}
