import 'package:flutter/material.dart';
import 'package:healthy_app/services/recomendaciones_services.dart';
import 'package:provider/provider.dart';

import 'package:healthy_app/widgets/center_text.dart';
import 'package:healthy_app/widgets/no_data_user.dart';
import 'package:healthy_app/services/auth_services.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final recomendaciones = Provider.of<RecomendacionesServices>(context);
    final usuario = authServices.usuario;

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
                  margin: const EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SintomasPage(
                              recomendaciones:
                                  recomendaciones.recomendacionesSintomas),
                        ),
                      );
                    },
                    child: const Text(
                      "Ver recomendaciones por sintomas",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
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
                          return ListView.builder(
                            itemCount: snapshot.data?.keys.toList().length,
                            itemBuilder: (context, index) {
                              final name = snapshot.data.keys.toList()[index];
                              final valores = snapshot.data[name];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
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
                                      margin: const EdgeInsets.only(bottom: 10),
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
                                      const Divider(),
                                    ],
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
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

  @override
  bool get wantKeepAlive => true;
}

class SintomasPage extends StatefulWidget {
  final Map<String, dynamic> recomendaciones;
  const SintomasPage({super.key, required this.recomendaciones});

  @override
  State<SintomasPage> createState() => _SintomasPageState();
}

class _SintomasPageState extends State<SintomasPage> {
  final searchController = TextEditingController();
  List<String> filteredData = [];

  @override
  void initState() {
    filteredData = widget.recomendaciones.keys.toList();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterData(String query) {
    setState(() {
      filteredData = widget.recomendaciones.keys
          .toList()
          .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Recomendaciones por sintomas"),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Buscar sintoma",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    filterData(value);
                  },
                ),
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: filteredData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final name = filteredData[index];
                    final valores = widget.recomendaciones[name];
                    return ExpansionTile(
                      title: Text(name),
                      children: [
                        for (var i in valores) ...[
                          ListTile(
                            title: Text(i["recomendacion"]),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
