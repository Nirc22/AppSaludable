import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthy_app/models/options.dart';
import 'package:healthy_app/models/usuario.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthServices>(context).usuario;
    final rol = usuario.rol;

    return Scaffold(
      body: AdminUI(usuario: usuario),
    );
  }
}

class AdminUI extends StatelessWidget {
  const AdminUI({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bienvenido ${usuario.nombre}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: Text(
              textAlign: TextAlign.center,
              "Panel de Administración",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: opciones.length,
                  itemBuilder: (context, index) {
                    Option opcion = opciones[index];
                    return Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.analytics_outlined,
                            size: 60,
                          ),
                          Text(
                            opcion.nombre,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
