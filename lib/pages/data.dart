import 'package:flutter/material.dart';
import 'package:healthy_app/services/fecha_services.dart';
import 'package:healthy_app/widgets/center_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DataPage extends StatelessWidget {
  DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fechaServices = Provider.of<FechaServices>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              const CenterText(texto: "Completa la información"),
              const SizedBox(height: 20),
              Expanded(
                child: Stepper(
                  steps: [
                    Step(
                      title: const Text("Datos Personales"),
                      content: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _FechaNacimiento(),
                                  _CalculatedData(
                                    texto: fechaServices.edad.toString(),
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FechaNacimiento extends StatelessWidget {
  const _FechaNacimiento({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fecha de Nacimiento:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          DatePicker(),
        ],
      ),
    );
  }
}

class _CalculatedData extends StatelessWidget {
  const _CalculatedData({
    Key? key,
    required this.texto,
  }) : super(key: key);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Text(
            "Edad:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              texto,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  DatePicker({super.key});

  DateTime initialDate = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  DateTime lastDate = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  DateTime firstDate = DateTime(DateTime.now().year - 80);

  @override
  Widget build(BuildContext context) {
    final fechaServices = Provider.of<FechaServices>(context);

    return ElevatedButton(
      child: fechaServices.seleccionado
          ? Text(DateFormat("dd/MM/yyyy").format(fechaServices.fechaNacimiento))
          : const Text("Seleccionar fecha"),
      onPressed: () => selectDate(context),
    );
  }

  void selectDate(BuildContext context) async {
    final fechaServices = Provider.of<FechaServices>(context, listen: false);

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (dateTime != null) {
      fechaServices.fechaNacimiento = dateTime;
      fechaServices.seleccionado = true;
      if (fechaServices.seleccionado) {
        fechaServices.edad =
            DateTime.now().year - fechaServices.fechaNacimiento.year;
      }
    }
  }
}
