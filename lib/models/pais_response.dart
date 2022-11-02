// To parse this JSON data, do
//
//     final paisResponse = paisResponseFromJson(jsonString);

import 'dart:convert';

import 'package:healthy_app/models/pais.dart';

PaisResponse paisResponseFromJson(String str) =>
    PaisResponse.fromJson(json.decode(str));

String paisResponseToJson(PaisResponse data) => json.encode(data.toJson());

class PaisResponse {
  PaisResponse({
    required this.ok,
    required this.msg,
    required this.paises,
  });

  bool ok;
  String msg;
  List<Pais> paises;

  factory PaisResponse.fromJson(Map<String, dynamic> json) => PaisResponse(
        ok: json["ok"],
        msg: json["msg"],
        paises: List<Pais>.from(json["pais"].map((x) => Pais.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "pais": List<dynamic>.from(paises.map((x) => x.toJson())),
      };
}
