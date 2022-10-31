import 'dart:convert';

Rol rolFromJson(String str) => Rol.fromJson(json.decode(str));
String rolToJson(Rol data) => json.encode(data.toJson());

class Rol {
  Rol({
    required this.id,
    required this.nombre,
    required this.v,
  });

  String id;
  String nombre;
  int v;

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
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
