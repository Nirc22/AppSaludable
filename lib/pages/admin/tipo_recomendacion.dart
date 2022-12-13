import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/models/tipo_recomendacion.dart';
import 'package:healthy_app/services/tipo_recomendacion_services.dart';

class TipoRecomendacionPage extends StatelessWidget {
  const TipoRecomendacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tiposRecomendacion =
        Provider.of<TipoRecomendacionServices>(context).tiposRecomendacion;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador Tipos de Recomendación"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Nombre")),
            ],
            source: TipoRecomendacionData(tiposRecomendacion),
          ),
        ],
      ),
    );
  }
}

class TipoRecomendacionData extends DataTableSource {
  final List<TipoRecomendacion> tiposRecomendacion;

  TipoRecomendacionData(this.tiposRecomendacion);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(tiposRecomendacion[index].nombre)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tiposRecomendacion.length;

  @override
  int get selectedRowCount => 0;
}
