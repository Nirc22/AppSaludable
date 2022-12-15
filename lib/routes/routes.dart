import 'package:flutter/material.dart';
import 'package:healthy_app/pages/admin/pais.dart';
import 'package:healthy_app/pages/admin/parametro.dart';
import 'package:healthy_app/pages/admin/recomendaciones.dart';
import 'package:healthy_app/pages/admin/riesgos.dart';
import 'package:healthy_app/pages/admin/tipo_parametro.dart';
import 'package:healthy_app/pages/admin/tipo_recomendacion.dart';

import 'package:healthy_app/pages/login.dart';
import 'package:healthy_app/pages/register.dart';
import 'package:healthy_app/pages/loading.dart';
import 'package:healthy_app/pages/tabs_page.dart';
import 'package:healthy_app/pages/data.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "login": (BuildContext context) => LoginPage(),
  "register": (BuildContext context) => RegisterPage(),
  "loading": (BuildContext context) => LoadingPage(),
  "tabs": (BuildContext context) => TabsPage(),
  "data": (BuildContext context) => DataPage(),
  "pais": (BuildContext context) => PaisPage(),
  "riesgos": (BuildContext context) => RiesgosPage(),
  "tipoRecomendacion": (BuildContext context) => TipoRecomendacionPage(),
  "tipoParametro": (BuildContext context) => TipoParametroPage(),
  "parametro": (BuildContext context) => ParametroPage(),
  "recomendaciones": (BuildContext context) => RecomendacionesPage(),
};
