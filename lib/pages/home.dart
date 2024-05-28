import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/pages/inicio.dart';
import 'package:proyecto_consultorio/pages/perfil.dart';
import 'package:proyecto_consultorio/utils/storage.dart';
import 'package:proyecto_consultorio/pages/login.dart';
import 'package:proyecto_consultorio/pages/crearCuenta.dart';
import 'package:proyecto_consultorio/pages/cambiarContra.dart';
import 'package:proyecto_consultorio/pages/doctores.dart';
import 'package:proyecto_consultorio/pages/citaAgendada.dart';
import 'package:proyecto_consultorio/pages/cita.dart';


class Home extends StatefulWidget {
  const Home({super.key});

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
              child: const Text("Ir a Inicia Sesión"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => sign(),
                  ),
                );
              },
              child: const Text("Crear cuenta"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => changePass(),
                  ),
                );
              },
              child: const Text("Cambiar contraseña"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctoresPage(),
                  ),
                );
              },
              child: const Text("Doctores"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CitaAgendada(),
                  ),
                );
              },
              child: const Text("Cita Agendada"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cita(),
                  ),
                );*/
              },
              child: const Text("Cita"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async{
              await deleteSessionData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
              child: const Text('Cerrar Sesión'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async{
              await deleteSessionData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => perfil(),
                ),
              );
            },
              child: const Text('Perfil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Inicio(),
                  ),
                );
              },
              child: const Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}