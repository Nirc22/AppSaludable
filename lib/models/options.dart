class Option {
  String nombre;
  String ruta;

  Option({required this.nombre, required this.ruta});
}

List<Option> opciones = [
  Option(nombre: "Paises", ruta: "profile"),
  Option(nombre: "Riesgos", ruta: "profile"),
  Option(nombre: "Tipos de recomendación", ruta: "profile"),
  Option(nombre: "Recomendaciones", ruta: "profile"),
  Option(nombre: "Tipos de parametros", ruta: "profile"),
  Option(nombre: "Parametros", ruta: "profile"),
  Option(nombre: "Tipos de examen", ruta: "profile"),
  Option(nombre: "Examenes", ruta: "profile"),
];
