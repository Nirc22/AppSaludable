import 'package:flutter/material.dart';
import 'package:healthy_app/models/tipoRiesgo.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/services/riesgo_services.dart';
import 'package:healthy_app/widgets/custom_input_form.dart';

class RiesgosPage extends StatelessWidget {
  const RiesgosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final riesgos = Provider.of<RiesgoServices>(context).riesgos;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador Riesgos"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Nombre")),
              DataColumn(label: Text("Valor Minimo")),
              DataColumn(label: Text("Valor Maximo")),
              DataColumn(label: Text("Administrar Recomendaciones")),
            ],
            source: RiesgosData(riesgos),
          ),
        ],
      ),
    );
  }
}

class RiesgosData extends DataTableSource {
  final List<TipoRiesgo> riesgos;

  RiesgosData(this.riesgos);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(riesgos[index].nombre)),
        DataCell(Text(riesgos[index].rangoMinimo.toStringAsFixed(1))),
        DataCell(Text(riesgos[index].rangoMaximo.toStringAsFixed(1))),
        DataCell(
          Builder(builder: (context) {
            return TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UpdateRecomendacionesPage(riesgo: riesgos[index]),
                  // AddParametroPage(),
                ),
              ),
              child: const Text(
                "Administrar",
                style: TextStyle(color: Colors.blue),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => riesgos.length;

  @override
  int get selectedRowCount => 0;
}

class UpdateRecomendacionesPage extends StatefulWidget {
  final TipoRiesgo riesgo;
  const UpdateRecomendacionesPage({super.key, required this.riesgo});

  @override
  State<UpdateRecomendacionesPage> createState() =>
      _UpdateRecomendacionesPageState();
}

class _UpdateRecomendacionesPageState extends State<UpdateRecomendacionesPage> {
  late TipoRiesgo riesgo;
  final recomendacionCtrl = TextEditingController();

  @override
  void initState() {
    riesgo = widget.riesgo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrar Recomendaciones"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomInputForm(
              textController: recomendacionCtrl,
              texto: "Recomendación:",
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  riesgo.recomendaciones.add(recomendacionCtrl.text);
                  recomendacionCtrl.text = "";
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Agregar Recomendación",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Recomendaciones: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: riesgo.recomendaciones.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey<String>(riesgo.recomendaciones[index]),
                    background: Container(
                      color: Colors.red,
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text("- ${riesgo.recomendaciones[index]}."),
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        riesgo.recomendaciones.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => actualizarParametro(context, riesgo.id, riesgo),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Actualizar Recomendaciones",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future actualizarParametro(
      BuildContext context, String id, TipoRiesgo riesgo) async {
    final riesgoServices = Provider.of<RiesgoServices>(context, listen: false);
    final token = await AuthServices.getToken();

    await riesgoServices.updateRiesgo(id, riesgo, token);
    Navigator.pushNamed(context, "riesgos");
  }
}
