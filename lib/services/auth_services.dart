import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_app/global/environments.dart';
import 'package:healthy_app/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices with ChangeNotifier {
  late LoginResponse loginResponse;
  bool _autenticando = false;
  bool get autenticando => _autenticando;
  final _storage = FlutterSecureStorage();

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
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
      loginResponse = loginResponseFromJson(resp.body);
      await _guardarToken(loginResponse.token);
      Map<String, dynamic> json = jsonDecode(resp.body);
      return {"ok": json["ok"], "msg": json["msg"]};
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
      Map<String, dynamic> json = jsonDecode(resp.body);
      return {"ok": json["ok"], "msg": json["msg"]};
    } else {
      if (resp.statusCode == 201) {
        Map<String, dynamic> json = jsonDecode(resp.body);
        final error = json["errors"].keys.first;
        final msgError = json["errors"][error]["msg"];
        return {"ok": false, "msg": msgError};
      } else {
        return {"ok": false, "msg": "Ha surgido un error inesperado"};
      }
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future _logout() async {
    return await _storage.delete(key: "token");
  }

  Future isLoggedIn() async {
    final token = _storage.read(key: "token");
    print(token);
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
