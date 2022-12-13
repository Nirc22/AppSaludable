// To parse this JSON data, do
//     final tipoRecomendacionResponse = tipoRecomendacionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:healthy_app/models/tipo_recomendacion.dart';

TipoRecomendacionResponse tipoRecomendacionResponseFromJson(String str) =>
    TipoRecomendacionResponse.fromJson(json.decode(str));

String tipoRecomendacionResponseToJson(TipoRecomendacionResponse data) =>
    json.encode(data.toJson());

class TipoRecomendacionResponse {
  TipoRecomendacionResponse({
    required this.ok,
    required this.msg,
    required this.tipoRecomendacion,
  });

  bool ok;
  String msg;
  List<TipoRecomendacion> tipoRecomendacion;

  factory TipoRecomendacionResponse.fromJson(Map<String, dynamic> json) =>
      TipoRecomendacionResponse(
        ok: json["ok"],
        msg: json["msg"],
        tipoRecomendacion: List<TipoRecomendacion>.from(
            json["tipoRecomendacion"]
                .map((x) => TipoRecomendacion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "tipoRecomendacion":
            List<dynamic>.from(tipoRecomendacion.map((x) => x.toJson())),
      };
}
