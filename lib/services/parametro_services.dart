import 'package:flutter/material.dart';
import 'package:healthy_app/models/parametro_response.dart';
import 'package:http/http.dart' as http;

import 'package:healthy_app/global/environments.dart';
import 'package:healthy_app/models/parametro.dart';

class ParametroServices with ChangeNotifier {
  List<Parametro> enfermedades = [];
  List<bool> isCheckedEnfermedades = [];

  ParametroServices() {
    getEnfermedades();
  }

  changeIsCheckedEnfermedades(int index, bool value) {
    isCheckedEnfermedades[index] = value;
    notifyListeners();
  }

  resetearIsCheckedEnfermedades() {
    isCheckedEnfermedades =
        List<bool>.filled(enfermedades.length, false, growable: false);
    notifyListeners();
  }

  getEnfermedades() async {
    final url = Uri.parse(
        "${Enviroments.apiUrl}/parametro/tipo/633cbb3f67036daacefd537c");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final parametroResponse = parametroResponseFromJson(resp.body);
    enfermedades = parametroResponse.parametros;
    isCheckedEnfermedades =
        List<bool>.filled(enfermedades.length, false, growable: false);
    notifyListeners();
  }
}
