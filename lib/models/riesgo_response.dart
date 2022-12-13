// To parse this JSON data, do
//     final riesgosResponse = riesgosResponseFromJson(jsonString);
import 'dart:convert';
import 'package:healthy_app/models/tipoRiesgo.dart';

RiesgosResponse riesgosResponseFromJson(String str) =>
    RiesgosResponse.fromJson(json.decode(str));

String riesgosResponseToJson(RiesgosResponse data) =>
    json.encode(data.toJson());

class RiesgosResponse {
  RiesgosResponse({
    required this.ok,
    required this.msg,
    required this.riesgos,
  });

  bool ok;
  String msg;
  List<TipoRiesgo> riesgos;

  factory RiesgosResponse.fromJson(Map<String, dynamic> json) =>
      RiesgosResponse(
        ok: json["ok"],
        msg: json["msg"],
        riesgos: List<TipoRiesgo>.from(
            json["riesgos"].map((x) => TipoRiesgo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "riesgos": List<dynamic>.from(riesgos.map((x) => x.toJson())),
      };
}
