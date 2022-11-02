import 'package:flutter/material.dart';

class FechaServices with ChangeNotifier {
  DateTime _fechaNacimiento = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  DateTime get fechaNacimiento => _fechaNacimiento;

  set fechaNacimiento(DateTime valor) {
    _fechaNacimiento = valor;
    notifyListeners();
  }

  bool _seleccionado = false;
  bool get seleccionado => _seleccionado;
  set seleccionado(bool valor) {
    _seleccionado = valor;
    notifyListeners();
  }

  int _edad = 0;
  int get edad => _edad;
  set edad(int value) {
    _edad = value;
    notifyListeners();
  }
}
