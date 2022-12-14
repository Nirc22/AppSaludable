import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:healthy_app/services/riesgo_services.dart';

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
            ],
            source: RiesgosData(riesgos),
          ),
        ],
      ),
    );
  }
}

class RiesgosData extends DataTableSource {
  final List<dynamic> riesgos;

  RiesgosData(this.riesgos);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(riesgos[index].nombre)),
        DataCell(Text(riesgos[index].rangoMinimo.toStringAsFixed(1))),
        DataCell(Text(riesgos[index].rangoMaximo.toStringAsFixed(1))),
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
