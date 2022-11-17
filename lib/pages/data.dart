import 'package:flutter/material.dart';
import 'package:healthy_app/models/parametro.dart';
import 'package:healthy_app/services/parametro_services.dart';
import 'package:healthy_app/widgets/custom_input_form.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:healthy_app/widgets/center_text.dart';
import 'package:healthy_app/services/data_services.dart';
import 'package:healthy_app/services/pais_services.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  TextEditingController pesoCtrl = TextEditingController();
  TextEditingController alturaCtrl = TextEditingController();
  int pasoActual = 0;

  @override
  void initState() {
    pesoCtrl.text = "0";
    alturaCtrl.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataServices = Provider.of<DataServices>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              const CenterText(texto: "Completa la información"),
              const SizedBox(height: 20),
              Expanded(
                child: Stepper(
                  physics: const ScrollPhysics(),
                  currentStep: pasoActual,
                  onStepCancel: cancel,
                  onStepTapped: (paso) => tapped(paso),
                  onStepContinue: continued,
                  steps: [
                    Step(
                      state: pasoActual > 0
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: pasoActual >= 0,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _FechaNacimiento(),
                                      _CalculatedData(
                                        texto: dataServices.edad.toString(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _PaisOrigen(),
                                      SizedBox(width: 20),
                                      _PaisResidencia(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: CustomInputForm(
                                          texto: "Peso (Kg):",
                                          textController: pesoCtrl,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      Spacer(),
                                      Flexible(
                                        child: CustomInputForm(
                                          texto: "Altura (cm):",
                                          textController: alturaCtrl,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                  _Sexo()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      state: pasoActual > 1
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: pasoActual >= 1,
                      title: const Text("Antecedentes Familiares"),
                      content: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _AntecedentesFamiliares(),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      state: pasoActual > 2
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: pasoActual >= 2,
                      title: const Text("Enfermedades Usuario"),
                      content: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _EnfermedadesUsuario(),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      title: const Text("Habitos de vida"),
                      content: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                "Con qué frecuencia realiza las siguientes actividades:"),
                            _Habitos(),
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

  tapped(int step) {
    setState(() {
      pasoActual = step;
    });
  }

  continued() {
    if (pasoActual < 1) {
      setState(() {
        pasoActual += 1;
      });
    } else if (pasoActual == 1) {
      final datos = Provider.of<DataServices>(context, listen: false);
      print("Datos:  ");
      print(datos.fechaNacimiento);
      print(datos.edad);
      print(datos.paisOrigen);
      print(datos.paisResidencia);
      print(pesoCtrl.text);
      print(alturaCtrl.text);
      print(datos.sexo);
      print(datos.antecedentesFamiliares);

      double imc = int.parse(alturaCtrl.text) / int.parse(pesoCtrl.text);
      print(imc);
    }
  }

  cancel() {
    if (pasoActual == 0) {
      Navigator.pop(context);
    } else if (pasoActual > 0) {
      setState(() {
        pasoActual -= 1;
      });
    }
  }
}

class _Habitos extends StatelessWidget {
  const _Habitos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final habitosServices = Provider.of<ParametroServices>(context);
    final habitos = habitosServices.habitos;

    return ListView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: habitos.length,
      itemBuilder: (context, index) => _HabitoRadio(
        habito: habitos[index].nombre,
      ),
    );
  }
}

class _HabitoRadio extends StatefulWidget {
  final String habito;
  const _HabitoRadio({
    Key? key,
    required this.habito,
  }) : super(key: key);

  @override
  State<_HabitoRadio> createState() => _HabitoRadioState();
}

class _HabitoRadioState extends State<_HabitoRadio> {
  int? currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.habito}: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile(
            title: Text("Nunca"),
            value: 0,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value);
            },
          ),
          RadioListTile(
            title: Text("Algunas veces"),
            value: 1,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value);
            },
          ),
          RadioListTile(
            title: Text("Frecuentemente"),
            value: 2,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value);
            },
          ),
          RadioListTile(
            title: Text("Diariamente"),
            value: 3,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value);
            },
          ),
        ],
      ),
    );
  }

  changeValue(int? value) {
    setState(() {
      currentValue = value;
    });
  }
}

class _EnfermedadesUsuario extends StatefulWidget {
  const _EnfermedadesUsuario({
    Key? key,
  }) : super(key: key);

  @override
  State<_EnfermedadesUsuario> createState() => _EnfermedadesUsuarioState();
}

class _EnfermedadesUsuarioState extends State<_EnfermedadesUsuario> {
  @override
  Widget build(BuildContext context) {
    final parametroServices = Provider.of<ParametroServices>(context);
    final dataServices = Provider.of<DataServices>(context);

    return Container(
      child: Column(
        children: [
          for (var i in dataServices.enfermedadesUsuario) ...[
            Text(i["enfermedad"] as String),
          ],
          ListView.builder(
            shrinkWrap: true,
            itemCount: parametroServices.enfermedades.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(parametroServices.enfermedades[index].nombre),
                value: parametroServices.isCheckedEnfermedades[index],
                onChanged: (value) {
                  setState(() {
                    parametroServices.changeIsCheckedEnfermedades(
                        index, value as bool);
                    if (parametroServices.isCheckedEnfermedades[index]) {
                      dataServices.enfermedadesUsuario.add({
                        "enfermedad": parametroServices.enfermedades[index].id
                      });
                    } else {
                      dataServices.enfermedadesUsuario.removeWhere((i) =>
                          i["enfermedad"] ==
                          parametroServices.enfermedades[index].id);
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AntecedentesFamiliares extends StatefulWidget {
  const _AntecedentesFamiliares({
    Key? key,
  }) : super(key: key);

  @override
  State<_AntecedentesFamiliares> createState() =>
      _AntecedentesFamiliaresState();
}

class _AntecedentesFamiliaresState extends State<_AntecedentesFamiliares> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final parametroServices = Provider.of<ParametroServices>(context);
    final dataServices = Provider.of<DataServices>(context);

    return Container(
      child: Column(
        children: [
          for (var i in dataServices.antecedentesFamiliares) ...[
            Text(i["enfermedad"] as String),
          ],
          ListView.builder(
            shrinkWrap: true,
            itemCount: parametroServices.enfermedades.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(parametroServices.enfermedades[index].nombre),
                value: parametroServices.isCheckedAntecedentes[index],
                onChanged: (value) {
                  setState(() {
                    parametroServices.changeIsCheckedAntecedentes(
                        index, value as bool);
                    if (parametroServices.isCheckedAntecedentes[index]) {
                      dataServices.antecedentesFamiliares.add({
                        "enfermedad": parametroServices.enfermedades[index].id
                      });
                    } else {
                      dataServices.antecedentesFamiliares.removeWhere((i) =>
                          i["enfermedad"] ==
                          parametroServices.enfermedades[index].id);
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Sexo extends StatelessWidget {
  const _Sexo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataServices = Provider.of<DataServices>(context);
    final List<String> sexo = ["Masculino", "Femenino"];

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sexo:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          DropdownButton(
            value: dataServices.sexo,
            items: sexo
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null && dataServices.sexo != value) {
                dataServices.sexo = value;
              }
            },
          ),
        ],
      ),
    );
  }
}

class _PaisResidencia extends StatelessWidget {
  const _PaisResidencia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paises = Provider.of<PaisServices>(context).paises;
    final dataServices = Provider.of<DataServices>(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "País de residencia:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          DropdownButton(
            value: dataServices.paisResidencia,
            items: paises
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    child: Text(item.nombre),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null && dataServices.paisResidencia != value) {
                dataServices.paisResidencia = value;
              }
            },
          ),
        ],
      ),
    );
  }
}

class _PaisOrigen extends StatelessWidget {
  const _PaisOrigen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paises = Provider.of<PaisServices>(context).paises;
    final dataServices = Provider.of<DataServices>(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "País de origen:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          DropdownButton(
            value: dataServices.paisOrigen,
            items: paises
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    child: Text(item.nombre),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null && dataServices.paisOrigen != value) {
                dataServices.paisOrigen = value;
              }
            },
          ),
        ],
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
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Fecha de Nacimiento:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
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
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          const Text(
            "Edad:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

  final DateTime initialDate = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  final DateTime lastDate = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  final DateTime firstDate = DateTime(DateTime.now().year - 80);

  @override
  Widget build(BuildContext context) {
    final dataServices = Provider.of<DataServices>(context);

    return ElevatedButton(
      child: dataServices.fechaNacimientoSeleccionada
          ? Text(DateFormat("dd/MM/yyyy").format(dataServices.fechaNacimiento))
          : const Text("Seleccionar fecha"),
      onPressed: () => selectDate(context),
    );
  }

  void selectDate(BuildContext context) async {
    final dataServices = Provider.of<DataServices>(context, listen: false);

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (dateTime != null) {
      dataServices.fechaNacimiento = dateTime;
      dataServices.fechaNacimientoSeleccionada = true;
      if (dataServices.fechaNacimientoSeleccionada) {
        dataServices.edad =
            DateTime.now().year - dataServices.fechaNacimiento.year;
      }
    }
  }
}
