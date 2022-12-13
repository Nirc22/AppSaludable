import 'package:flutter/material.dart';
import 'package:healthy_app/models/parametro_response.dart';
import 'package:http/http.dart' as http;

import 'package:healthy_app/global/environments.dart';
import 'package:healthy_app/models/parametro.dart';

class ParametroServices with ChangeNotifier {
  List<Parametro> parametros = [];
  List<Parametro> enfermedades = [];
  List<Parametro> habitos = [];
  List<bool> isCheckedAntecedentes = [];
  List<bool> isCheckedEnfermedades = [];
  late List<Map<String, dynamic>> habitosUsuario;

  ParametroServices() {
    getParametros();
    getEnfermedades();
    getHabitos();
  }

  changeIsCheckedEnfermedades(int index, bool value) {
    isCheckedEnfermedades[index] = value;
    notifyListeners();
  }

  changeIsCheckedAntecedentes(int index, bool value) {
    isCheckedAntecedentes[index] = value;
    notifyListeners();
  }

  getEnfermedades() async {
    final url = Uri.parse(
        "${Enviroments.apiUrl}/parametro/tipo/633cbb3f67036daacefd537c");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final parametroResponse = parametroResponseFromJson(resp.body);
    enfermedades = parametroResponse.parametros;
    isCheckedAntecedentes =
        List<bool>.filled(enfermedades.length, false, growable: false);
    isCheckedEnfermedades =
        List<bool>.filled(enfermedades.length, false, growable: false);
    notifyListeners();
  }

  getHabitos() async {
    final url = Uri.parse(
        "${Enviroments.apiUrl}/parametro/tipo/632e67d77bab36dbf8f79e4c");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final parametroResponse = parametroResponseFromJson(resp.body);
    habitos = parametroResponse.parametros;
    habitosUsuario = List<Map<String, dynamic>>.filled(habitos.length, {});
    notifyListeners();
  }

  getParametros() async {
    final url = Uri.parse("${Enviroments.apiUrl}/parametro");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final parametroResponse = parametroResponseFromJson(resp.body);
    parametros = parametroResponse.parametros;
    notifyListeners();
  }

  crearParametro() async {
    final url = Uri.parse("${Enviroments.apiUrl}/parametro/create");

    final resp =
        await http.post(url, headers: {"Content-Type": "application/json"});

    final parametroResponse = parametroResponseFromJson(resp.body);
    parametros = parametroResponse.parametros;
    notifyListeners();
  }
}
