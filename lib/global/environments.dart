import 'dart:io';

class Enviroments {
  static String apiUrl = Platform.isAndroid
      ? "http://192.168.1.9:4001/api"
      : "http://localhost:4001/api";
}
