import 'dart:ffi';

import 'package:proyecto_consultorio/utils/constantes.dart';
import 'package:mongo_dart/mongo_dart.dart';

const citasCole = "citas";

class CitasDB {
  static var db, coleccionCitas;

  static conecctCitas() async {
    try {
      db = await Db.create(mongoConecctionURL);
      await db.open();
      coleccionCitas = db.collection(citasCole);
      print("Conexion exitosa");
    } catch (e) {
      print('Error al conectar a la base de datos: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getCitas() async {
    try {
      final citas = await coleccionCitas.find().toList();
      print("Citas obtenidas con exito");
      return citas;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getCitasFecha(String fecha, nombre) async {
    try {
      final citas = await coleccionCitas.find({'fecha': fecha,'nom_doctor':nombre}).toList();
      print("Citas obtenidas con exito");
      return citas;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return [];
    }
  }
  static Future<bool> getCitasDocUser(String nombre, String nombreUser) async {
    try {
      final citas = await coleccionCitas.find({'nom_doctor':nombre,'nom_user':nombreUser,'estado':'Pendiente'}).toList();
      if(citas.isNotEmpty){
        return true;
      }
      return false;

    } catch (e) {
      print('Error al obtener las citas: $e');
      return false;
  static Future<List<Map<String, dynamic>>> getCitasUsuario(String nombre) async {
    try {
      final citas = await coleccionCitas.find({'nom_user':nombre}).toList();
      print("Citas obtenidas con exito");
      return citas;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return [];
    }
  }
}