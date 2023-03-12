import 'package:flutter/material.dart';
import 'package:healthy_app/models/tipoParametro.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:healthy_app/services/tipo_parametro_services.dart';
import 'package:healthy_app/widgets/custom_button.dart';
import 'package:healthy_app/widgets/custom_input_form.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/models/parametro.dart';
import 'package:healthy_app/services/parametro_services.dart';

class ParametroPage extends StatefulWidget {
  const ParametroPage({super.key});

  @override
  State<ParametroPage> createState() => _ParametroPageState();
}

class _ParametroPageState extends State<ParametroPage> {
  @override
  Widget build(BuildContext context) {
    final parametros = Provider.of<ParametroServices>(context).parametros;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador Parametros"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Nombre")),
              DataColumn(label: Text("Tipo Parametro")),
              DataColumn(label: Text("Valor Riesgo")),
              DataColumn(label: Text("Acciones")),
            ],
            source: ParametroData(parametros, context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddParametroPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ParametroData extends DataTableSource {
  final List<Parametro> parametros;
  final BuildContext context;

  ParametroData(this.parametros, this.context);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(parametros[index].nombre)),
        DataCell(Text(parametros[index].tipoParametro.nombre)),
        DataCell(Text(parametros[index].valorRiesgo.toString())),
        DataCell(
          Row(
            children: [
              Builder(builder: (context) {
                return TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateParametroPage(parametro: parametros[index]),
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
                  onPressed: () =>
                      eliminarParametro(context, parametros[index].id),
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

  Future eliminarParametro(BuildContext context, String id) async {
    final parametroServices =
        Provider.of<ParametroServices>(context, listen: false);
    final token = await AuthServices.getToken();

    await parametroServices.eliminarParametro(id, token);
    // Navigator.pushNamed(context, "parametro");
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => parametros.length;

  @override
  int get selectedRowCount => 0;
}

class AddParametroPage extends StatefulWidget {
  const AddParametroPage({super.key});

  @override
  State<AddParametroPage> createState() => _AddParametroPageState();
}

class _AddParametroPageState extends State<AddParametroPage> {
  @override
  Widget build(BuildContext context) {
    final tipoParametros =
        Provider.of<TipoParametroServices>(context).tiposParametros;

    return ChangeNotifierProvider(
      create: (context) => ParametroDataForm(),
      builder: (context, child) => Scaffold(
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Agregar Parametro"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Formulario(tipoParametros: tipoParametros),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  final List<TipoParametro> tipoParametros;
  final String? token;

  const Formulario({super.key, required this.tipoParametros, this.token});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final nombresCtrl = TextEditingController();
  final valorRiesgoCtrl = TextEditingController();

  @override
  void initState() {
    valorRiesgoCtrl.text = "0";
    super.initState();
  }

  @override
  void dispose() {
    nombresCtrl.dispose();
    valorRiesgoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final authServices = Provider.of<AuthServices>(context);
    final parametroDataForm = Provider.of<ParametroDataForm>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputForm(
            textController: nombresCtrl,
            texto: "Nombre:",
          ),
          if (parametroDataForm.valorRiesgo != "632e694a7bab36dbf8f79e4f") ...[
            CustomInputForm(
              textController: valorRiesgoCtrl,
              texto: "Valor Riesgo:",
              keyboardType: TextInputType.number,
            ),
          ],
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Tipo Parametro:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          DropdownButton(
            value: parametroDataForm.valorRiesgo,
            items: widget.tipoParametros
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    child: Text(item.nombre),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              setState(() {
                parametroDataForm.valorRiesgo = value;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            texto: "Agregar",
            onPressed: () => crearParametro(context, nombresCtrl.text,
                valorRiesgoCtrl.text, parametroDataForm.valorRiesgo),
          ),
        ],
      ),
    );
  }

  Future crearParametro(BuildContext context, String nombre, String valorRiesgo,
      String? idTipoParametro) async {
    final parametroServices =
        Provider.of<ParametroServices>(context, listen: false);
    final token = await AuthServices.getToken();

    if (idTipoParametro == "632e694a7bab36dbf8f79e4f") {
      valorRiesgo = "0";
    }

    await parametroServices.crearParametro(
        nombre, valorRiesgo, idTipoParametro, token);
    Navigator.pushNamed(context, "parametro");
  }
}

class UpdateParametroPage extends StatefulWidget {
  final Parametro parametro;
  const UpdateParametroPage({super.key, required this.parametro});

  @override
  State<UpdateParametroPage> createState() => _UpdateParametroPageState();
}

class _UpdateParametroPageState extends State<UpdateParametroPage> {
  @override
  Widget build(BuildContext context) {
    final tipoParametros =
        Provider.of<TipoParametroServices>(context).tiposParametros;

    return ChangeNotifierProvider(
      create: (context) => ParametroDataForm(),
      builder: (context, child) => Scaffold(
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Actualizar Parametro"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    FormularioUpdate(
                      tipoParametros: tipoParametros,
                      parametro: widget.parametro,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormularioUpdate extends StatefulWidget {
  final Parametro parametro;
  final List<TipoParametro> tipoParametros;
  final String? token;

  const FormularioUpdate(
      {super.key,
      required this.tipoParametros,
      this.token,
      required this.parametro});

  @override
  State<FormularioUpdate> createState() => _FormularioUpdateState();
}

class _FormularioUpdateState extends State<FormularioUpdate> {
  final nombresCtrl = TextEditingController();
  final valorRiesgoCtrl = TextEditingController();
  late String? idTipoParametro;

  @override
  void initState() {
    valorRiesgoCtrl.text = widget.parametro.valorRiesgo.toString();
    nombresCtrl.text = widget.parametro.nombre;
    idTipoParametro = widget.parametro.tipoParametro.id;
    super.initState();
  }

  @override
  void dispose() {
    nombresCtrl.dispose();
    valorRiesgoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final authServices = Provider.of<AuthServices>(context);
    final parametroDataForm = Provider.of<ParametroDataForm>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputForm(
            textController: nombresCtrl,
            texto: "Nombre:",
          ),
          if (idTipoParametro != "632e694a7bab36dbf8f79e4f") ...[
            CustomInputForm(
              textController: valorRiesgoCtrl,
              texto: "Valor Riesgo:",
              keyboardType: TextInputType.number,
            ),
          ],
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Tipo Parametro:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          DropdownButton(
            value: idTipoParametro,
            items: widget.tipoParametros
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    child: Text(item.nombre),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              setState(() {
                idTipoParametro = value;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            texto: "Actualizar",
            onPressed: () => actualizarParametro(context, widget.parametro.id,
                nombresCtrl.text, valorRiesgoCtrl.text, idTipoParametro),
          ),
        ],
      ),
    );
  }

  Future actualizarParametro(BuildContext context, String id, String nombre,
      String valorRiesgo, String? idTipoParametro) async {
    final parametroServices =
        Provider.of<ParametroServices>(context, listen: false);
    final token = await AuthServices.getToken();

    if (idTipoParametro == "632e694a7bab36dbf8f79e4f") {
      valorRiesgo = "0";
    }

    await parametroServices.actualizarParametro(
        id, nombre, valorRiesgo, idTipoParametro, token);
    Navigator.pushNamed(context, "parametro");
  }
}

class ParametroDataForm with ChangeNotifier {
  String? _valorRiesgo = "633cbb3f67036daacefd537c";

  String? get valorRiesgo => _valorRiesgo;

  set valorRiesgo(String? value) {
    _valorRiesgo = value;
    notifyListeners();
  }
}
