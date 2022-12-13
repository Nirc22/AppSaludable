import 'package:flutter/material.dart';
import 'package:healthy_app/models/pais.dart';
import 'package:healthy_app/services/pais_services.dart';
import 'package:provider/provider.dart';

class PaisPage extends StatelessWidget {
  const PaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paises = Provider.of<PaisServices>(context).paises;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador Paises"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PaginatedDataTable(
            columns: const [
              DataColumn(
                label: Text("#"),
              ),
              DataColumn(
                label: Text("Nombre"),
              ),
            ],
            source: PaisData(paises),
          ),
        ],
      ),
    );
  }
}

class PaisData extends DataTableSource {
  final List<Pais> paises;

  PaisData(this.paises);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(paises[index].nombre)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => paises.length;

  @override
  int get selectedRowCount => 0;
}
