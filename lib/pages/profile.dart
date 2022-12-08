import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:healthy_app/services/auth_services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final usuario = authServices.usuario;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 70,
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    children: [
                      Text(
                        "${usuario.nombre} ${usuario.apellidos}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        usuario.rol.nombre,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              if (usuario.isCompleteData) ...[
                Text("Edad: ${usuario.edad} años"),
                Text("Sexo: ${usuario.sexo}"),
                Text("Peso: ${usuario.peso} Kg"),
                Text("Altura: ${usuario.altura} cm"),
              ],
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  authServices.logout();
                  Navigator.pushReplacementNamed(context, "login");
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Cerrar Sesión",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
