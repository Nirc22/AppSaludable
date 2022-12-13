import 'package:flutter/material.dart';
import 'package:healthy_app/models/riesgo_response.dart';
import 'package:http/http.dart' as http;

import 'package:healthy_app/global/environments.dart';

class RiesgoServices with ChangeNotifier {
  List<dynamic> riesgos = [];

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
}
