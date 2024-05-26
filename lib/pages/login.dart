import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
              fontFamily: 'OpenSans', // Utilizando la fuente Open Sans
              color: Color(0xFF0B8FAC), // Cambiar al color hexadecimal deseado
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/sanatec.jpg',
            width: 130,
          ), //no se porque aparece una linea verde abajo xd
          /*const Icon(
            Icons.favorite,
            size: 180,
            color: Colors.blue,
          ),*/
          const SizedBox(height: 20),
          const Text(
            "Iniciar sesión",
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                "Inicie sesión para agendar su cita médica",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Color(0xFF646464),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text(
                  "Teléfono",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0x40858585)), // Color del borde
                ),
                filled: true,
                fillColor: Color(0x40D9D9D9),
                hintText: "Ingrese su teléfono", // Placeholder
                hintStyle: TextStyle(color: Colors.grey), // Color de fondo
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
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0x40858585)), // Color del borde
                ),
                filled: true,
                fillColor: const Color(0x40D9D9D9), // Color de fondo
                hintText: "Ingrese su contraseña", // Placeholder
                hintStyle:
                    const TextStyle(color: Colors.grey), // Estilo del placeholder
                suffixIcon: IconButton(
                  icon: Icon(
                      _ocultarContra ? Icons.visibility_off : Icons.visibility),
                  color: const Color(0xFF0B8FAC),
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
            child: SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  _validarLogin();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B8FAC), // Color de fondo
                  padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 15), // Ajusta el espaciado interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Ingresar",
                  style: GoogleFonts.openSans(
                    fontSize: 18, // Ajusta el tamaño del texto
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes cuenta? ",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF646464),
                      fontSize: 14,
                    ),

                  ),
                  Text(
                    "Crea una",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B8FAC),
                        fontSize: 14,
                      ),
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

  Future<void> _validarLogin() async {
    for (final usuario in usuarios) {
      if (usuario['telefono'] == _telefonoRe &&
          usuario['pass'] == _contrasenaRe) {
        await saveSessionData({
          'nombre': usuario['nom_user'],
          'telefono': usuario['telefono'],
          'contra': usuario['pass'],
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Telefono o Contraseña incorrectas')),
    );
  }
}
