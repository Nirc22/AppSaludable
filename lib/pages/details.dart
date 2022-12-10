import 'package:flutter/material.dart';
import 'package:healthy_app/services/recomendaciones_services.dart';
import 'package:provider/provider.dart';

import 'package:healthy_app/widgets/center_text.dart';
import 'package:healthy_app/widgets/no_data_user.dart';
import 'package:healthy_app/services/auth_services.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final usuario = Provider.of<AuthServices>(context).usuario;
    final recomendaciones = Provider.of<RecomendacionesServices>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const CenterText(texto: "Detalles de recomendaciones"),
              const SizedBox(height: 15),
              if (!usuario.isCompleteData) ...[
                const NoDataUser(),
              ] else ...[
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Ver recomendaciones por sintomas",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Recomendaciones por enfermedad",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FutureBuilder(
                      future: getRecomendacionesPorEnfermedad(
                          context, usuario.id as String),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print("Data: ${snapshot.data}");
                          return ListView.builder(
                            itemCount: snapshot.data?.keys.toList().length,
                            itemBuilder: (context, index) {
                              final name = snapshot.data.keys.toList()[index];
                              final valores = snapshot.data[name];
                              print("Valores: ${valores}");
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "$name:",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    for (var i in valores) ...[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          i["recomendacion"],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future getRecomendacionesPorEnfermedad(
      BuildContext context, String id) async {
    final recomendaciones =
        Provider.of<RecomendacionesServices>(context, listen: false);
    final token = await AuthServices.getToken();

    final result =
        await recomendaciones.recomendacionesPorEnfermedad(id, token as String);
    return result["recomendaciones"];
  }
}
