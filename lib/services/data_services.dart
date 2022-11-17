import 'package:flutter/material.dart';

class DataServices with ChangeNotifier {
  DateTime _fechaNacimiento = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  DateTime get fechaNacimiento => _fechaNacimiento;

  set fechaNacimiento(DateTime valor) {
    _fechaNacimiento = valor;
    notifyListeners();
  }

  bool _fechaNacimientoSeleccionado = false;
  bool get fechaNacimientoSeleccionada => _fechaNacimientoSeleccionado;
  set fechaNacimientoSeleccionada(bool valor) {
    _fechaNacimientoSeleccionado = valor;
    notifyListeners();
  }

  int _edad = 0;
  int get edad => _edad;
  set edad(int value) {
    _edad = value;
    notifyListeners();
  }

  String? _paisOrigen = "632a875828c688f4b785e95a";
  String? _paisResidencia = "632a875828c688f4b785e95a";

  String? get paisOrigen => _paisOrigen;
  set paisOrigen(String? value) {
    _paisOrigen = value;
    notifyListeners();
  }

  String? get paisResidencia => _paisResidencia;
  set paisResidencia(String? value) {
    _paisResidencia = value;
    notifyListeners();
  }

  String? _sexo = "Masculino";

  String? get sexo => _sexo;
  set sexo(String? value) {
    _sexo = value;
    notifyListeners();
  }

  List<Map<String, String>> antecedentesFamiliares = [];
  List<Map<String, String>> enfermedadesUsuario = [];
}
