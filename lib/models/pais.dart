// To parse this JSON data, do
//
//     final pais = paisFromJson(jsonString);

import 'dart:convert';

List<Pais> paisFromJson(String str) =>
    List<Pais>.from(json.decode(str).map((x) => Pais.fromJson(x)));

String paisToJson(List<Pais> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pais {
  Pais({
    required this.id,
    required this.nombre,
    required this.v,
  });

  String id;
  String nombre;
  int v;

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
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
