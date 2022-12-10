// To parse this JSON data, do
//
//     final recomendacion = recomendacionFromJson(jsonString);

import 'dart:convert';

import 'package:healthy_app/models/parametro.dart';
import 'package:healthy_app/models/tipo_recomendacion.dart';

Recomendacion recomendacionFromJson(String str) =>
    Recomendacion.fromJson(json.decode(str));

String recomendacionToJson(Recomendacion data) => json.encode(data.toJson());

class Recomendacion {
  Recomendacion({
    required this.id,
    required this.idTipoRecomendacion,
    required this.nombre,
    required this.recomendacion,
    required this.v,
    required this.idParametro,
    required this.prioridad,
  });

  String id;
  TipoRecomendacion idTipoRecomendacion;
  String nombre;
  String recomendacion;
  int v;
  Parametro idParametro;
  int prioridad;

  factory Recomendacion.fromJson(Map<String, dynamic> json) => Recomendacion(
        id: json["_id"],
        idTipoRecomendacion:
            TipoRecomendacion.fromJson(json["idTipoRecomendacion"]),
        nombre: json["nombre"],
        recomendacion: json["recomendacion"],
        v: json["__v"],
        idParametro: Parametro.fromJson(json["idParametro"]),
        prioridad: json["prioridad"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "idTipoRecomendacion": idTipoRecomendacion.toJson(),
        "nombre": nombre,
        "recomendacion": recomendacion,
        "__v": v,
        "idParametro": idParametro.toJson(),
        "prioridad": prioridad,
      };
}
