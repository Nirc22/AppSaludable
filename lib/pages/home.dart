import 'package:flutter/material.dart';
import 'package:healthy_app/models/options.dart';
import 'package:healthy_app/models/usuario.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:healthy_app/widgets/center_text.dart';
import 'package:healthy_app/widgets/no_data_user.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthServices>(context).usuario;
    final rol = usuario.rol;

    return SafeArea(
      child: Scaffold(
        body: rol.nombre == "Usuario"
            ? UserUI(usuario: usuario)
            : AdminUI(usuario: usuario),
      ),
    );
  }
}

class UserUI extends StatelessWidget {
  const UserUI({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TextHeader(usuario: usuario),
          const SizedBox(height: 20),
          if (usuario.enfermedadesUsuario.isEmpty ||
              usuario.antecedentesFamiliares.isEmpty) ...[
            const NoDataUser(),
          ],
        ],
      ),
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
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TextHeader(usuario: usuario),
          const SizedBox(height: 20),
          const CenterText(texto: "Panel de Administración"),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        const Icon(
                          Icons.analytics_outlined,
                          size: 60,
                        ),
                        Text(
                          opcion.nombre,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TextHeader extends StatelessWidget {
  const _TextHeader({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Bienvenido ${usuario.nombre},",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
