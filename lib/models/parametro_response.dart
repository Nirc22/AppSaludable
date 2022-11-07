// To parse this JSON data, do
//
//     final parametroResponse = parametroResponseFromJson(jsonString);

import 'dart:convert';

import 'package:healthy_app/models/parametro.dart';

ParametroResponse parametroResponseFromJson(String str) =>
    ParametroResponse.fromJson(json.decode(str));

String parametroResponseToJson(ParametroResponse data) =>
    json.encode(data.toJson());

class ParametroResponse {
  ParametroResponse({
    required this.ok,
    required this.msg,
    required this.parametros,
  });

  bool ok;
  String msg;
  List<Parametro> parametros;

  factory ParametroResponse.fromJson(Map<String, dynamic> json) =>
      ParametroResponse(
        ok: json["ok"],
        msg: json["msg"],
        parametros: List<Parametro>.from(
            json["parametros"].map((x) => Parametro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "parametros": List<dynamic>.from(parametros.map((x) => x.toJson())),
      };
}
