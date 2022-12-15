import 'package:flutter/material.dart';
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
            ],
            source: RecomendacionesData(recomendaciones),
          ),
        ],
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
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => recomendaciones.length;

  @override
  int get selectedRowCount => 0;
}
