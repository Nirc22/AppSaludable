import 'package:flutter/material.dart';
import 'package:healthy_app/models/parametro.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:healthy_app/services/parametro_services.dart';
import 'package:healthy_app/widgets/custom_button.dart';
import 'package:healthy_app/widgets/custom_input_form.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/services/recomendaciones_services.dart';

class RecomendacionesPage extends StatefulWidget {
  const RecomendacionesPage({super.key});

  @override
  State<RecomendacionesPage> createState() => _RecomendacionesPageState();
}

class _RecomendacionesPageState extends State<RecomendacionesPage> {
  @override
  Widget build(BuildContext context) {
    final recomendaciones =
        Provider.of<RecomendacionesServices>(context).recomendaciones;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador Recomendaciones"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Tipo Parametro")),
              DataColumn(label: Text("Tipo Recomendación")),
              DataColumn(label: Text("Recomendación")),
              DataColumn(label: Text("Acciones")),
            ],
            source: RecomendacionesData(recomendaciones),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddRecomendacionesPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RecomendacionesData extends DataTableSource {
  final List<dynamic> recomendaciones;

  RecomendacionesData(this.recomendaciones);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(recomendaciones[index]["idParametro"]["nombre"])),
        DataCell(Text(recomendaciones[index]["idTipoRecomendacion"]["nombre"])),
        DataCell(Text(recomendaciones[index]["recomendacion"])),
        DataCell(
          Row(
            children: [
              Builder(builder: (context) {
                return TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateRecomendacionPage(
                        recomendacion: recomendaciones[index],
                      ),
                      // AddParametroPage(),
                    ),
                  ),
                  child: const Text(
                    "Editar",
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }),
              Builder(builder: (context) {
                return TextButton(
                  onPressed: () => eliminarRecomendacion(
                      context, recomendaciones[index]["_id"]),
                  child: const Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Future eliminarRecomendacion(BuildContext context, String id) async {
    final recomendacionServices =
        Provider.of<RecomendacionesServices>(context, listen: false);

    final token = await AuthServices.getToken();

    await recomendacionServices.eliminarRecomendacion(id, token);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => recomendaciones.length;

  @override
  int get selectedRowCount => 0;
}

class AddRecomendacionesPage extends StatelessWidget {
  const AddRecomendacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final enfermedades = Provider.of<ParametroServices>(context).enfermedades;
    final sintomas = Provider.of<ParametroServices>(context).sintomas;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Recomendaciones"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Agregar recomendaciones por:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecomendacionEnfermedadPage(
                    enfermedades: enfermedades,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: const Text(
                  "Enfermedades",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecomendacionSintomaPage(
                    sintomas: sintomas,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: const Text(
                  "Sintomas",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Prioridad {
  String id;
  String prioridad;

  Prioridad({required this.id, required this.prioridad});
}

class AddRecomendacionEnfermedadPage extends StatefulWidget {
  final List<Parametro> enfermedades;
  const AddRecomendacionEnfermedadPage({super.key, required this.enfermedades});

  @override
  State<AddRecomendacionEnfermedadPage> createState() =>
      _AddRecomendacionEnfermedadPageState();
}

class _AddRecomendacionEnfermedadPageState
    extends State<AddRecomendacionEnfermedadPage> {
  late String? enfermedad;
  String? prioridad = "1";
  final recomendacionCtrl = TextEditingController();
  final List<Prioridad> prioridades = [
    Prioridad(id: "1", prioridad: "Baja"),
    Prioridad(id: "2", prioridad: "Normal"),
    Prioridad(id: "3", prioridad: "Alta"),
  ];

  @override
  void initState() {
    enfermedad = widget.enfermedades[0].id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Recomendaciones por Enfermedad"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Enfermedad:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            DropdownButton(
              value: enfermedad,
              items: widget.enfermedades
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.nombre),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  enfermedad = value;
                });
              },
            ),
            CustomInputForm(
              texto: "Recomendación:",
              textController: recomendacionCtrl,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Prioridad:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            DropdownButton(
              value: prioridad,
              items: prioridades
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.prioridad),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  prioridad = value;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              texto: "Agregar",
              onPressed: () => crearRecomendacion(
                  context, enfermedad, recomendacionCtrl.text, prioridad),
            ),
          ],
        ),
      ),
    );
  }

  Future crearRecomendacion(BuildContext context, String? idParametro,
      String recomendacion, String? prioridad) async {
    final recomendacionServices =
        Provider.of<RecomendacionesServices>(context, listen: false);
    final token = await AuthServices.getToken();

    const idTipoRecomendacion = "633218cd05abbcd8122d35ad";

    await recomendacionServices.crearRecomendacion(
        idTipoRecomendacion, idParametro, recomendacion, prioridad, token);
    Navigator.pushNamed(context, "recomendaciones");
  }
}

class AddRecomendacionSintomaPage extends StatefulWidget {
  final List<Parametro> sintomas;
  const AddRecomendacionSintomaPage({super.key, required this.sintomas});

  @override
  State<AddRecomendacionSintomaPage> createState() =>
      _AddRecomendacionSintomaPageState();
}

class _AddRecomendacionSintomaPageState
    extends State<AddRecomendacionSintomaPage> {
  late String? sintoma;
  String? prioridad = "1";
  final recomendacionCtrl = TextEditingController();
  final List<Prioridad> prioridades = [
    Prioridad(id: "1", prioridad: "Baja"),
    Prioridad(id: "2", prioridad: "Normal"),
    Prioridad(id: "3", prioridad: "Alta"),
  ];

  @override
  void initState() {
    sintoma = widget.sintomas[0].id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Recomendaciones por Sintoma"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Sintoma:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            DropdownButton(
              value: sintoma,
              items: widget.sintomas
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.nombre),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  sintoma = value;
                });
              },
            ),
            CustomInputForm(
              texto: "Recomendación:",
              textController: recomendacionCtrl,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Prioridad:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            DropdownButton(
              value: prioridad,
              items: prioridades
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.prioridad),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  prioridad = value;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              texto: "Agregar",
              onPressed: () => crearRecomendacion(
                  context, sintoma, recomendacionCtrl.text, prioridad),
            ),
          ],
        ),
      ),
    );
  }

  Future crearRecomendacion(BuildContext context, String? idParametro,
      String recomendacion, String? prioridad) async {
    final recomendacionServices =
        Provider.of<RecomendacionesServices>(context, listen: false);
    final token = await AuthServices.getToken();

    const idTipoRecomendacion = "633cb4feb71ce1c00491b4f5";

    await recomendacionServices.crearRecomendacion(
        idTipoRecomendacion, idParametro, recomendacion, prioridad, token);
    Navigator.pushNamed(context, "recomendaciones");
  }
}

class UpdateRecomendacionPage extends StatefulWidget {
  final dynamic recomendacion;

  const UpdateRecomendacionPage({super.key, required this.recomendacion});

  @override
  State<UpdateRecomendacionPage> createState() =>
      _UpdateRecomendacionPageState();
}

class _UpdateRecomendacionPageState extends State<UpdateRecomendacionPage> {
  late dynamic recomendacion;
  String? prioridad = "1";
  final recomendacionCtrl = TextEditingController();
  final List<Prioridad> prioridades = [
    Prioridad(id: "1", prioridad: "Baja"),
    Prioridad(id: "2", prioridad: "Normal"),
    Prioridad(id: "3", prioridad: "Alta"),
  ];

  @override
  void initState() {
    recomendacion = widget.recomendacion;
    recomendacionCtrl.text = widget.recomendacion["recomendacion"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sintomas = Provider.of<ParametroServices>(context).sintomas;
    final enfermedades = Provider.of<ParametroServices>(context).enfermedades;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Recomendaciones"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Sintoma:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            DropdownButton(
              value: recomendacion["idParametro"]["_id"] as String,
              items: recomendacion["idTipoRecomendacion"]["_id"] ==
                      "633cb4feb71ce1c00491b4f5"
                  ? sintomas
                      .map(
                        (item) => DropdownMenuItem(
                          value: item.id,
                          child: Text(item.nombre),
                        ),
                      )
                      .toList()
                  : enfermedades
                      .map(
                        (item) => DropdownMenuItem(
                          value: item.id,
                          child: Text(item.nombre),
                        ),
                      )
                      .toList(),
              onChanged: (String? value) {
                setState(() {
                  recomendacion["idParametro"]["_id"] = value as String;
                });
              },
            ),
            CustomInputForm(
              texto: "Recomendación:",
              textController: recomendacionCtrl,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Prioridad:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            DropdownButton(
              value: prioridad,
              items: prioridades
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.prioridad),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  prioridad = value;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              texto: "Actualizar",
              onPressed: () => actualizarRecomendacion(
                  context,
                  recomendacion["_id"],
                  recomendacion["idParametro"]["_id"],
                  recomendacion["idTipoRecomendacion"]["_id"],
                  recomendacionCtrl.text,
                  prioridad),
            ),
          ],
        ),
      ),
    );
  }

  Future actualizarRecomendacion(
      BuildContext context,
      String idRecomendacion,
      String? idParametro,
      String idTipoRecomendacion,
      String recomendacion,
      String? prioridad) async {
    final recomendacionServices =
        Provider.of<RecomendacionesServices>(context, listen: false);
    final token = await AuthServices.getToken();

    await recomendacionServices.actualizarRecomendacion(idRecomendacion,
        idTipoRecomendacion, idParametro, recomendacion, prioridad, token);
    Navigator.pushNamed(context, "recomendaciones");
  }
}
