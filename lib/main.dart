import 'package:flutter/material.dart';
import 'package:healthy_app/services/recomendaciones_services.dart';
import 'package:healthy_app/services/riesgo_services.dart';
import 'package:healthy_app/services/tipo_parametro_services.dart';
import 'package:healthy_app/services/tipo_recomendacion_services.dart';
import 'package:provider/provider.dart';

import 'package:healthy_app/routes/routes.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:healthy_app/services/data_services.dart';
import 'package:healthy_app/services/pais_services.dart';
import 'package:healthy_app/services/parametro_services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaisServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => ParametroServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecomendacionesServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => RiesgoServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => TipoRecomendacionServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => TipoParametroServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthy App',
        initialRoute: "loading",
        routes: appRoutes,
      ),
    );
  }
}
