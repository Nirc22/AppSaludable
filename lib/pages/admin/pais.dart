import 'package:flutter/material.dart';
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
      body: Container(
        width: double.infinity,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text("#"),
            ),
            DataColumn(
              label: Text("Nombre"),
            ),
          ],
          rows: paises.map((pais) {
            return DataRow(
              cells: [
                DataCell(Text((paises.indexOf(pais) + 1).toString())),
                DataCell(Text(pais.nombre)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
