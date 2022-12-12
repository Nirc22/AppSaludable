import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_app/models/recomendacionesResponse.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_app/global/environments.dart';

class RecomendacionesServices with ChangeNotifier {
  late Map<String, dynamic> recomendacionesSintomas;

  RecomendacionesServices() {
    recomendacionesPorSintoma();
  }

  Future<Map<String, dynamic>> recomendacionesPorEnfermedad(
      String id, String token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/recomendacion/usuario/$id");

    final resp = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    // print(resp.body);

    if (resp.statusCode == 200) {
      final recomendaciones = recomendacionesResponseFromJson(resp.body);

      return {
        "ok": true,
        "msg": "Lista de Recomendaciones Por Enfermedad",
        "recomendaciones": recomendaciones.recomendaciones
      };
    } else {
      return {"ok": false, "msg": "Se ha producido un error"};
    }
  }

  Future<Map<String, dynamic>> recomendacionesPorSintoma() async {
    final url = Uri.parse("${Enviroments.apiUrl}/recomendacion/sintomas");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    // print(resp.body);

    if (resp.statusCode == 200) {
      final recomendaciones = recomendacionesResponseFromJson(resp.body);
      recomendacionesSintomas = recomendaciones.recomendaciones;
      return {"ok": true, "msg": "Lista de Recomendaciones Por Sintomas"};
    } else {
      return {"ok": false, "msg": "Se ha producido un error"};
    }
  }
}