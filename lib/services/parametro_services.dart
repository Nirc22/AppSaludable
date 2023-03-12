import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_app/models/parametro_response.dart';
import 'package:http/http.dart' as http;

import 'package:healthy_app/global/environments.dart';
import 'package:healthy_app/models/parametro.dart';

class ParametroServices with ChangeNotifier {
  List<Parametro> parametros = [];
  List<Parametro> enfermedades = [];
  List<Parametro> sintomas = [];
  List<Parametro> habitos = [];
  List<bool> isCheckedAntecedentes = [];
  List<bool> isCheckedEnfermedades = [];
  late List<Map<String, dynamic>> habitosUsuario;

  ParametroServices() {
    getParametros();
    getEnfermedades();
    getSintomas();
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

  getSintomas() async {
    final url = Uri.parse(
        "${Enviroments.apiUrl}/parametro/tipo/632e694a7bab36dbf8f79e4f");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final parametroResponse = parametroResponseFromJson(resp.body);
    sintomas = parametroResponse.parametros;
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

  crearParametro(String nombre, String valorRiesgo, String? idTipoParametro,
      String? token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/parametro/create");

    final data = {
      "nombre": allWordsCapitilize(nombre),
      "valorRiesgo": valorRiesgo,
      "idTipoParametro": idTipoParametro
    };

    final resp = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data));

    final parametroResponse = parametroResponseFromJson(resp.body);
    parametros = parametroResponse.parametros;
    notifyListeners();
  }

  actualizarParametro(String id, String nombre, String valorRiesgo,
      String? idTipoParametro, String? token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/parametro/update/$id");

    final data = {
      "nombre": allWordsCapitilize(nombre),
      "valorRiesgo": valorRiesgo,
      "idTipoParametro": idTipoParametro
    };

    final resp = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data));

    final parametroResponse = parametroResponseFromJson(resp.body);
    parametros = parametroResponse.parametros;
    notifyListeners();
  }

  eliminarParametro(String id, String? token) async {
    final url = Uri.parse("${Enviroments.apiUrl}/parametro/delete/$id");

    final resp = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    final parametroResponse = parametroResponseFromJson(resp.body);
    parametros = parametroResponse.parametros;
    notifyListeners();
  }
}

String allWordsCapitilize(String str) {
  if (str.length > 0) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  } else {
    return "";
  }
}
