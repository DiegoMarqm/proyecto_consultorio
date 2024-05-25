import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/utils/storage.dart';
import 'package:proyecto_consultorio/pages/login.dart';
import 'package:proyecto_consultorio/pages/crearCuenta.dart';
import 'package:proyecto_consultorio/pages/cambiarContra.dart';
import 'package:proyecto_consultorio/pages/doctores.dart';
import 'package:proyecto_consultorio/pages/citaAgendada.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {
  String _nombreUsuario = ""; // Inicializar _nombreUsuario con una cadena vacía

  Future<void> _loadData() async {
    // Recuperar datos de usuario del almacenamiento
    Map<String, dynamic> userData = await getSessionData();
    if (userData.isNotEmpty) {
      setState(() { // Usar setState para actualizar la interfaz de usuario en base a los datos
        _nombreUsuario = userData['nombre'];
      });
    }
    print(userData['nombre']);
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Cargar datos al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_nombreUsuario),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
              child: Text("Ir a Inicia Sesión"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => sign(),
                  ),
                );
              },
              child: Text("Crear cuenta"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => changePass(),
                  ),
                );
              },
              child: Text("Cambiar contraseña"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => doctores(),
                  ),
                );
              },
              child: Text("Doctores"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => citaAgendada(),
                  ),
                );
              },
              child: Text("Cita Agendada"),
            ),

            ElevatedButton(onPressed: () async{
              await deleteSessionData();
              // Navegar de vuelta a la pantalla de inicio de sesión
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
              child: Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}