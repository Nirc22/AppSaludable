import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:healthy_app/widgets/center_text.dart';
import 'package:healthy_app/widgets/no_data_user.dart';
import 'package:healthy_app/services/auth_services.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthServices>(context).usuario;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const CenterText(texto: "Detalles de recomendaciones"),
              const SizedBox(height: 20),
              if (!usuario.isCompleteData) ...[
                const NoDataUser(),
              ] else ...[
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Recomendaciones por enfermedad"),
                      ),
                      FutureBuilder(
                        future: checkLoginState(context),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final autenticado = await authServices.isLoggedIn();
  }
}
