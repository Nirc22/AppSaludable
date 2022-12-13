import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/models/tipoParametro.dart';
import 'package:healthy_app/services/tipo_parametro_services.dart';

class TipoParametroPage extends StatelessWidget {
  const TipoParametroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tiposParametro =
        Provider.of<TipoParametroServices>(context).tiposParametros;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador Tipos de Parametros"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Nombre")),
            ],
            source: TipoParametroData(tiposParametro),
          ),
        ],
      ),
    );
  }
}

class TipoParametroData extends DataTableSource {
  final List<TipoParametro> tiposParametro;

  TipoParametroData(this.tiposParametro);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(tiposParametro[index].nombre)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tiposParametro.length;

  @override
  int get selectedRowCount => 0;
}
