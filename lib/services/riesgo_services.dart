import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_app/models/riesgo_response.dart';
import 'package:healthy_app/models/tipoRiesgo.dart';
import 'package:http/http.dart' as http;

import 'package:healthy_app/global/environments.dart';

class RiesgoServices with ChangeNotifier {
  List<TipoRiesgo> riesgos = [];

  RiesgoServices() {
    getRiesgos();
  }

  getRiesgos() async {
    final url = Uri.parse("${Enviroments.apiUrl}/riesgo");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final riesgosResponse = riesgosResponseFromJson(resp.body);
    riesgos = riesgosResponse.riesgos;
    notifyListeners();
  }

  updateRiesgo(String id, TipoRiesgo riesgo, String? token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/riesgo/update/$id");

    final resp = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(riesgo.toJson()));

    final riesgosResponse = riesgosResponseFromJson(resp.body);
    riesgos = riesgosResponse.riesgos;
    notifyListeners();
  }
}
