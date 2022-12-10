// To parse this JSON data, do
//
//     final tipoRecomendacion = tipoRecomendacionFromJson(jsonString);

import 'dart:convert';

TipoRecomendacion tipoRecomendacionFromJson(String str) =>
    TipoRecomendacion.fromJson(json.decode(str));

String tipoRecomendacionToJson(TipoRecomendacion data) =>
    json.encode(data.toJson());

class TipoRecomendacion {
  TipoRecomendacion({
    required this.id,
    required this.nombre,
    required this.v,
  });

  String id;
  String nombre;
  int v;

  factory TipoRecomendacion.fromJson(Map<String, dynamic> json) =>
      TipoRecomendacion(
        id: json["_id"],
        nombre: json["nombre"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "__v": v,
      };
}
