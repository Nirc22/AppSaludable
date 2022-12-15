// To parse this JSON data, do
// final recomendacionesGeneralesResponse = recomendacionesGeneralesResponseFromJson(jsonString);

import 'dart:convert';
import 'package:healthy_app/models/recomendacion.dart';

RecomendacionesGeneralesResponse recomendacionesGeneralesResponseFromJson(
        String str) =>
    RecomendacionesGeneralesResponse.fromJson(json.decode(str));

String recomendacionesGeneralesResponseToJson(
        RecomendacionesGeneralesResponse data) =>
    json.encode(data.toJson());

class RecomendacionesGeneralesResponse {
  RecomendacionesGeneralesResponse({
    required this.ok,
    required this.msg,
    required this.recomendaciones,
  });

  bool ok;
  String msg;
  List<dynamic> recomendaciones;

  factory RecomendacionesGeneralesResponse.fromJson(
          Map<String, dynamic> json) =>
      RecomendacionesGeneralesResponse(
        ok: json["ok"],
        msg: json["msg"],
        recomendaciones: json["recomendaciones"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "recomendaciones": recomendaciones,
      };
}
