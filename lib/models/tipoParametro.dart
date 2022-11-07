// To parse this JSON data, do
//
//     final tipoParametro = tipoParametroFromJson(jsonString);

import 'dart:convert';

TipoParametro tipoParametroFromJson(String str) =>
    TipoParametro.fromJson(json.decode(str));

String tipoParametroToJson(TipoParametro data) => json.encode(data.toJson());

class TipoParametro {
  TipoParametro({
    required this.id,
    required this.nombre,
    required this.v,
  });

  String id;
  String nombre;
  int v;

  factory TipoParametro.fromJson(Map<String, dynamic> json) => TipoParametro(
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
