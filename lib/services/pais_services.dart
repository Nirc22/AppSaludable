import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_app/models/pais_response.dart';
import 'package:http/http.dart' as http;

import 'package:healthy_app/models/pais.dart';
import 'package:healthy_app/global/environments.dart';

class PaisServices with ChangeNotifier {
  List<Pais> paises = [];
  String? _paisOrigen = "632a875828c688f4b785e95a";
  String? _paisResidencia = "632a875828c688f4b785e95a";

  PaisServices() {
    getPaises();
  }

  String? get paisOrigen => _paisOrigen;
  set paisOrigen(String? value) {
    _paisOrigen = value;
    notifyListeners();
  }

  getPaises() async {
    final url = Uri.parse("${Enviroments.apiUrl}/pais");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final paisResponse = paisResponseFromJson(resp.body);
    paises = paisResponse.paises;
    notifyListeners();
  }
}
