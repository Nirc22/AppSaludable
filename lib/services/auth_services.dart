import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_app/global/environments.dart';
import 'package:healthy_app/models/login_response.dart';
import 'package:healthy_app/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices with ChangeNotifier {
  late Usuario usuario;

  bool _autenticando = false;
  bool get autenticando => _autenticando;

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  final _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: "token");
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    autenticando = true;
    final data = {
      "email": email.toLowerCase(),
      "password": password.toLowerCase()
    };
    final url = Uri.parse("${Enviroments.apiUrl}/usuario/login");

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    print(resp.body);
    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return {"ok": true, "msg": "Ingreso Exitoso"};
    } else {
      return {"ok": false, "msg": "Revise sus credenciales"};
    }
  }

  Future<Map<String, dynamic>> register(
      String nombre, String apellidos, String email, String password) async {
    autenticando = true;

    final data = {
      "nombre": allWordsCapitilize(nombre),
      "apellidos": allWordsCapitilize(apellidos),
      "email": email.toLowerCase(),
      "password": password.toLowerCase()
    };

    final url = Uri.parse("${Enviroments.apiUrl}/usuario/create");

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    print(resp.body);

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return {"ok": true, "msg": "Registro Exitoso"};
    } else {
      return {
        "ok": false,
        "msg": "Revise la información ingresada en el formulario"
      };
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    return await _storage.delete(key: "token");
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: "token");

    final url = Uri.parse("${Enviroments.apiUrl}/usuario/renew");

    final resp = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  String allWordsCapitilize(String str) {
    if (str.length > 0) {
      return str.toLowerCase().split(' ').map((word) {
        String leftText =
            (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText;
      }).join(' ');
    } else {
      return "";
    }
  }
}
