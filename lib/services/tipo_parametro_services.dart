import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_app/models/tipoParametro.dart';
import 'package:healthy_app/models/tipo_parametro_response.dart';

import 'package:healthy_app/global/environments.dart';

class TipoParametroServices with ChangeNotifier {
  List<TipoParametro> tiposParametros = [];

  TipoParametroServices() {
    getTiposParametros();
  }

  getTiposParametros() async {
    final url = Uri.parse("${Enviroments.apiUrl}/tipoParametro");

    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    final tipoParametroServices = tipoParametroResponseFromJson(resp.body);
    tiposParametros = tipoParametroServices.tipoParametro;
    notifyListeners();
  }
}
