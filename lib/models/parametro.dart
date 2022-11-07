// To parse this JSON data, do
//
//     final parametro = parametroFromJson(jsonString);

import 'dart:convert';

import 'package:healthy_app/models/tipoParametro.dart';

Parametro parametroFromJson(String str) => Parametro.fromJson(json.decode(str));

String parametroToJson(Parametro data) => json.encode(data.toJson());

class Parametro {
  Parametro({
    required this.id,
    required this.tipoParametro,
    required this.nombre,
    required this.valorRiesgo,
    required this.v,
  });

  String id;
  TipoParametro tipoParametro;
  String nombre;
  int valorRiesgo;
  int v;

  factory Parametro.fromJson(Map<String, dynamic> json) => Parametro(
        id: json["_id"],
        tipoParametro: TipoParametro.fromJson(json["idTipoParametro"]),
        nombre: json["nombre"],
        valorRiesgo: json["valorRiesgo"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "idTipoParametro": tipoParametro.toJson(),
        "nombre": nombre,
        "valorRiesgo": valorRiesgo,
        "__v": v,
      };
}
