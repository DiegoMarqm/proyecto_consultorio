import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proyecto_consultorio/utils/constantes.dart';

const usersCole = "usuarios";

class UserDB{
  static var db, coleccionUsuarios;
  static conecctUsers() async{
    try {
      db = await Db.create(mongoConecctionURL);
      await db.open();
      inspect(db);
      coleccionUsuarios = db.collection(usersCole);
      print("Conexion exitosa");
    } catch (e) {
      print('Error al conectar a la base de datos: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getUsuarios() async {
    try {
      final usuarios = await coleccionUsuarios.find().toList();
      print("Usuarios obtenidos con exito");
      return usuarios;

    } catch (e) {
      print('Error al obtener los usuarios: $e');
      return [];
    }
  }
}