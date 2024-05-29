import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:proyecto_consultorio/utils/constantes.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

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

  static Future<List<Map<String, dynamic>>> getCitasFecha(
      String fecha, String nombre) async {
    try {
      actualizarCitasAntiguas();
      final citas = await coleccionCitas
          .find({'fecha': fecha, 'nom_doctor': nombre}).toList();
      print("Citas obtenidas con exito");
      return citas;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return [];
    }
  }

  static Future<bool> getCitasDocUser(
      String nombreDoc, String nombreUser) async {
    try {
      actualizarCitasAntiguas();
      final citas = await coleccionCitas.find({
        'nom_doctor': nombreDoc,
        'nom_user': nombreUser,
        'estado': 'Pendiente'
      }).toList();
      if (citas.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getCitasUsuario(
      String nombre) async {
    try {
      final citas = await coleccionCitas.find({'nom_user': nombre}).toList();
      print("Citas obtenidas con exito");
      return citas;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return [];
    }
  }

  static Future<void> actualizarCitasAntiguas() async {
    try {
      final citas = await coleccionCitas.find({'estado': 'Pendiente'}).toList();
      final ahora = DateTime.now();
      final formatoFecha = DateFormat('dd MMMM yyyy');
      final formatoHora = DateFormat('hh:mm a');
      String limpiarFecha(String fecha) {
        return fecha.replaceAll(' de ', ' ');
      }

      for (var cita in citas) {
        try {
          final fechaLimpia = limpiarFecha(cita['fecha']);
          final fechaCita = formatoFecha.parse(fechaLimpia);
          final horaCita = formatoHora.parse(cita['hr_cita']);
          final fechaHoraCita = DateTime(fechaCita.year, fechaCita.month,
              fechaCita.day, horaCita.hour, horaCita.minute);

          if (fechaHoraCita.isBefore(ahora) ||
              fechaHoraCita.isAtSameMomentAs(ahora)) {
            await coleccionCitas.update(
              where.id(cita['_id']),
              modify.set('estado', 'Atendida'),
            );
            print('Cita actualizada a atendida: ${cita['_id']}');
          }
        } catch (e) {
          print('Error al procesar la cita: ${cita['_id']}, Error: $e');
        }
      }
    } catch (e) {
      print('Error al actualizar las citas: $e');
    }
  }

  static Future<void> cancelarCita(
      String doctor, String fecha, String hora) async {
    try {
      final result = await coleccionCitas.update(
          mongo.where
              .eq('nom_doctor', doctor)
              .eq('fecha', fecha)
              .eq('hr_cita', hora),
          mongo.modify.set('estado', 'Cancelada'));
      if (result['nModified'] == 0) {
        print('No se encontró ninguna cita que coincida con los criterios.');
      } else {
        print('Cita cancelada correctamente.');
      }
    } catch (e) {
      print('Error cancelando la cita: $e');
    }
  }
}
