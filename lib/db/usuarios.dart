import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proyecto_consultorio/utils/constantes.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

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


  static Future<void> updateContra(String _usuario, String contra) async {
    try {

      // Actualización en la base de datos
      final result = await coleccionUsuarios.update(
          mongo.where.eq('nom_user', _usuario),
          mongo.modify.set('pass', contra)
      );

      // Verificación del resultado
      if (result['nModified'] == 0) {
        print('No se encontró el usuario o la contraseña ya es la misma.');
      } else {
        print('Contraseña actualizada correctamente.');
      }
    } catch (e) {
      print('Error actualizando la contraseña: $e');
    }
  }

}