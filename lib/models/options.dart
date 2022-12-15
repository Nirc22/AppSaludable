class Option {
  String nombre;
  String ruta;

  Option({required this.nombre, required this.ruta});
}

List<Option> opciones = [
  Option(nombre: "Paises", ruta: "pais"),
  Option(nombre: "Riesgos", ruta: "riesgos"),
  Option(nombre: "Tipos de recomendación", ruta: "tipoRecomendacion"),
  Option(nombre: "Recomendaciones", ruta: "recomendaciones"),
  Option(nombre: "Tipos de parametros", ruta: "tipoParametro"),
  Option(nombre: "Parametros", ruta: "parametro"),
  // Option(nombre: "Tipos de examen", ruta: "riesgos"),
  // Option(nombre: "Examenes", ruta: "riesgos"),
];
