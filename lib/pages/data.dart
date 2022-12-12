import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthy_app/helpers/mostrar_alerta.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:healthy_app/services/parametro_services.dart';
import 'package:healthy_app/widgets/custom_input_form.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:healthy_app/widgets/center_text.dart';
import 'package:healthy_app/services/data_services.dart';
import 'package:healthy_app/services/pais_services.dart';

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

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
  void dispose() {
    pesoCtrl.dispose();
    alturaCtrl.dispose();
    super.dispose();
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
              const SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Es importante que ingrese la información lo más preciso posible para generar sus recomendaciones de salud de manera correcta, en caso de no tener algún dato se recomienda completar el formulario posteriormente.",
                  textAlign: TextAlign.justify,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 5),
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
                            Text(
                              "Seleccione si algun familiar padece o padeció alguna de las siguientes enfermedades:",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
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
                            Text(
                              "Seleccione si padece alguna de las siguientes enfermedades:",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
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
                              "Con qué frecuencia realiza las siguientes actividades:",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
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

  continued() async {
    if (pasoActual < 3) {
      setState(() {
        pasoActual += 1;
      });
    } else if (pasoActual == 3) {
      final datos = Provider.of<DataServices>(context, listen: false);
      final authServices = Provider.of<AuthServices>(context, listen: false);
      final parametroServices =
          Provider.of<ParametroServices>(context, listen: false);

      if (int.parse(pesoCtrl.text) != 0 && int.parse(alturaCtrl.text) != 0) {
        datos.imc = (int.parse(pesoCtrl.text) /
                pow((int.parse(alturaCtrl.text) / 100), 2))
            .toPrecision(1);
      }

      if (int.parse(pesoCtrl.text) == 0 || int.parse(alturaCtrl.text) == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Debe completar el campo de peso y altura"),
          ),
        );
      } else {
        final updateOk = await authServices.updateInfo(
            authServices.usuario.id,
            DateFormat("dd/MM/yyyy").format(datos.fechaNacimiento),
            datos.edad,
            datos.paisOrigen,
            datos.paisResidencia,
            pesoCtrl.text,
            alturaCtrl.text,
            datos.imc,
            datos.sexo,
            datos.antecedentesFamiliares,
            datos.enfermedadesUsuario,
            parametroServices.habitosUsuario);

        if (updateOk["ok"]) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(updateOk["msg"]),
                ),
              )
              .closed
              .then((_) => Navigator.pushReplacementNamed(context, "loading"));
        } else {
          mostrarAlerta(context, "Actualización incorrecta", updateOk["msg"]);
        }
      }
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
          indice: index,
          idHabito: habitos[index].id,
          habito: habitos[index].nombre,
          valorRiesgo: habitos[index].valorRiesgo),
    );
  }
}

class _HabitoRadio extends StatefulWidget {
  final String habito;
  final int indice;
  final String idHabito;
  final int valorRiesgo;

  const _HabitoRadio({
    Key? key,
    required this.habito,
    required this.indice,
    required this.valorRiesgo,
    required this.idHabito,
  }) : super(key: key);

  @override
  State<_HabitoRadio> createState() => _HabitoRadioState();
}

class _HabitoRadioState extends State<_HabitoRadio> {
  int? currentValue = 0;

  @override
  void initState() {
    final parametroServices =
        Provider.of<ParametroServices>(context, listen: false);
    parametroServices.habitosUsuario[widget.indice] = {
      "habito": widget.idHabito,
      "puntaje": 0
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.habito}: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          RadioListTile(
            title: Text("Nunca"),
            value: 0,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value, widget.indice, widget.idHabito);
            },
          ),
          RadioListTile(
            title: Text("Algunas veces"),
            value: 1,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value, widget.indice, widget.idHabito);
            },
          ),
          RadioListTile(
            title: Text("Frecuentemente"),
            value: 2,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value, widget.indice, widget.idHabito);
            },
          ),
          RadioListTile(
            title: Text("Diariamente"),
            value: 3,
            groupValue: currentValue,
            onChanged: (int? value) {
              changeValue(value, widget.indice, widget.idHabito);
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  changeValue(int? value, int indice, String idHabito) {
    setState(() {
      currentValue = value;
      final puntaje = (value! * widget.valorRiesgo);
      final parametroServices =
          Provider.of<ParametroServices>(context, listen: false);
      parametroServices.habitosUsuario[indice] = {
        "habito": idHabito,
        "puntaje": puntaje
      };
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
            Text(i),
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
                      dataServices.enfermedadesUsuario
                          .add(parametroServices.enfermedades[index].id);
                    } else {
                      dataServices.enfermedadesUsuario.removeWhere(
                          (i) => i == parametroServices.enfermedades[index].id);
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
            Text(i),
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
                      dataServices.antecedentesFamiliares
                          .add(parametroServices.enfermedades[index].id);
                    } else {
                      dataServices.antecedentesFamiliares.removeWhere(
                          (i) => i == parametroServices.enfermedades[index].id);
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
      child:
          Text(DateFormat("dd/MM/yyyy").format(dataServices.fechaNacimiento)),
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
