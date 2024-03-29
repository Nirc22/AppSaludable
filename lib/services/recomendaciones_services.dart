import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_app/models/recomendacion.dart';
import 'package:healthy_app/models/recomendacionesGeneralesResponse.dart';
import 'package:healthy_app/models/recomendacionesResponse.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_app/global/environments.dart';

class RecomendacionesServices with ChangeNotifier {
  List<dynamic> recomendaciones = [];
  late Map<String, dynamic> recomendacionesSintomas;

  RecomendacionesServices() {
    getRecomendaciones();
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
      notifyListeners();
      return {"ok": true, "msg": "Lista de Recomendaciones Por Sintomas"};
    } else {
      return {"ok": false, "msg": "Se ha producido un error"};
    }
  }

  Future<Map<String, dynamic>> getRecomendaciones() async {
    final url = Uri.parse("${Enviroments.apiUrl}/recomendacion");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    print(resp.body);

    if (resp.statusCode == 200) {
      final recomendacionesResp =
          recomendacionesGeneralesResponseFromJson(resp.body);
      recomendaciones = recomendacionesResp.recomendaciones;
      notifyListeners();
      return {"ok": true, "msg": "Lista de Recomendaciones Por Sintomas"};
    } else {
      return {"ok": false, "msg": "Se ha producido un error"};
    }
  }

  crearRecomendacion(String idTipoRecomendacion, String? idParametro,
      String recomendacion, String? prioridad, String? token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/recomendacion/create");

    final data = {
      "idTipoRecomendacion": idTipoRecomendacion,
      "idParametro": idParametro,
      "recomendacion": recomendacion,
      "prioridad": prioridad
    };

    final resp = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data));

    final recomendacionResponse =
        recomendacionesGeneralesResponseFromJson(resp.body);
    recomendaciones = recomendacionResponse.recomendaciones;
    notifyListeners();
  }

  actualizarRecomendacion(
      String id,
      String idTipoRecomendacion,
      String? idParametro,
      String recomendacion,
      String? prioridad,
      String? token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/recomendacion/update/$id");

    final data = {
      "idTipoRecomendacion": idTipoRecomendacion,
      "idParametro": idParametro,
      "recomendacion": recomendacion,
      "prioridad": prioridad
    };

    final resp = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data));

    final recomendacionResponse =
        recomendacionesGeneralesResponseFromJson(resp.body);
    recomendaciones = recomendacionResponse.recomendaciones;
    notifyListeners();
  }

  eliminarRecomendacion(String id, String? token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/recomendacion/delete/$id");

    final resp = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    final recomendacionResponse =
        recomendacionesGeneralesResponseFromJson(resp.body);
    recomendaciones = recomendacionResponse.recomendaciones;
    notifyListeners();
  }
}
