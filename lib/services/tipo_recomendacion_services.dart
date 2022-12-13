import 'package:flutter/material.dart';
import 'package:healthy_app/models/tipo_recomendacion.dart';
import 'package:healthy_app/models/tipo_recomendacion_response.dart';
import 'package:http/http.dart' as http;

import 'package:healthy_app/global/environments.dart';

class TipoRecomendacionServices with ChangeNotifier {
  List<TipoRecomendacion> tiposRecomendacion = [];

  TipoRecomendacionServices() {
    getTiposRecomendacion();
  }

  getTiposRecomendacion() async {
    final url = Uri.parse("${Enviroments.apiUrl}/tipoRecomendacion");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final tipoRecomendacionServices =
        tipoRecomendacionResponseFromJson(resp.body);
    tiposRecomendacion = tipoRecomendacionServices.tipoRecomendacion;
    notifyListeners();
  }
}
