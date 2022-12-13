// To parse this JSON data, do
//     final tipoParametroResponse = tipoParametroResponseFromJson(jsonString);

import 'dart:convert';
import 'package:healthy_app/models/tipoParametro.dart';

TipoParametroResponse tipoParametroResponseFromJson(String str) =>
    TipoParametroResponse.fromJson(json.decode(str));

String tipoParametroResponseToJson(TipoParametroResponse data) =>
    json.encode(data.toJson());

class TipoParametroResponse {
  TipoParametroResponse({
    required this.ok,
    required this.msg,
    required this.tipoParametro,
  });

  bool ok;
  String msg;
  List<TipoParametro> tipoParametro;

  factory TipoParametroResponse.fromJson(Map<String, dynamic> json) =>
      TipoParametroResponse(
        ok: json["ok"],
        msg: json["msg"],
        tipoParametro: List<TipoParametro>.from(
            json["tipoParametro"].map((x) => TipoParametro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "tipoParametro":
            List<dynamic>.from(tipoParametro.map((x) => x.toJson())),
      };
}
