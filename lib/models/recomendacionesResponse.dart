// To parse this JSON data, do
//  final recomendacionesResponse = recomendacionesResponseFromJson(jsonString);

import 'dart:convert';
import 'package:healthy_app/models/parametro.dart';

RecomendacionesResponse recomendacionesResponseFromJson(String str) =>
    RecomendacionesResponse.fromJson(json.decode(str));

String recomendacionesResponseToJson(RecomendacionesResponse data) =>
    json.encode(data.toJson());

class RecomendacionesResponse {
  RecomendacionesResponse({
    required this.ok,
    required this.msg,
    required this.recomendaciones,
  });

  bool ok;
  String msg;
  Map<String, dynamic> recomendaciones;

  factory RecomendacionesResponse.fromJson(Map<String, dynamic> json) =>
      RecomendacionesResponse(
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
