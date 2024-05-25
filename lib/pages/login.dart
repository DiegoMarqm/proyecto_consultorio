import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_consultorio/pages/crearCuenta.dart';
import 'package:proyecto_consultorio/db/usuarios.dart';
import 'package:proyecto_consultorio/pages/home.dart';
import 'package:proyecto_consultorio/utils/storage.dart';

import 'package:proyecto_consultorio/pages/pruebaD.dart';
import 'dart:async';


import 'package:proyecto_consultorio/pages/doctores.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.conecct();
  runApp(login());
}

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _ocultarContra = true;
  String _telefonoRe = "";
  String _contrasenaRe = "";

  List<Map<String, dynamic>> usuarios = [];

  Future<void> obtenerUsuarios() async {
    final usuarios = await MongoDB.getUsuarios();
    setState(() {
      this.usuarios = usuarios;
    });
  }

  @override
  void initState() {
    super.initState();
    obtenerUsuarios();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Center(
          //child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //children: [
          const SizedBox(height: 50),
          const Text(
            "Bienvenidos",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Image.asset('assets/logo.jpg',width:100,),
          const Icon(
            Icons.favorite,
            size: 180,
            color: Colors.blue,
          ),
          const Text(
            "Iniciar sesión",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Text(
                  "Inicie sesión para agendar su cita médica",
                  style: TextStyle(),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text(
                  "Teléfono",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Ingrese su telefono",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _telefonoRe = value;
                });
              },
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text(
                  "Contraseña",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                      _ocultarContra ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _ocultarContra = !_ocultarContra;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _contrasenaRe = value;
                });
              },
              obscureText: _ocultarContra,
              obscuringCharacter: "*",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                _validarLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 50),
              ),
              child: const Text(
                "Ingresar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => sign()));
              },
              splashColor: Colors.transparent,
              child:  const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes cuenta? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Crear una",
                    style: TextStyle(color: Colors.cyan),
                  ),
                ],
              ),

            ),
          ),
          //],
          //),
          //),
        ],
      ),
    );
  }
  Future<void> _validarLogin() async{
    for (final usuario in usuarios) {
      if (usuario['telefono'] == _telefonoRe && usuario['pass'] == _contrasenaRe) {

        await saveSessionData({
          'nombre': usuario['nom_user'],
          'telefono': usuario['telefono'],
          'contra': usuario['pass'],
        });

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home()),
        );
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content:
          Text('Telefono o Contraseña incorrectas')
      ),
    );
  }
}
