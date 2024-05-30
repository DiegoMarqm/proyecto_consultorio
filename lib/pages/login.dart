import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/pages/crearCuenta.dart';
import 'package:proyecto_consultorio/db/usuarios.dart';
import 'package:proyecto_consultorio/utils/storage.dart';
import 'dart:async';
import 'package:proyecto_consultorio/pages/inicio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserDB.conecctUsers(); //se conecta a la base de datos de usuarios
  runApp(login());
}

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _ocultarContra = true;
  String _telefonoRe = ""; //almacena los datos
  String _contrasenaRe = "";

  List<Map<String, dynamic>> usuarios = []; //obtiene la lista de los usuarios de bd

  Future<void> obtenerUsuarios() async {  //función asíncrona que obtiene los usuarios de la base de datos y actualiza el estado
    final usuarios = await UserDB.getUsuarios();
    setState(() {
      this.usuarios = usuarios;
    });
  }

  @override
  void initState() {  //Inicializa el estado del widget y llama a obtenerUsuarios
    super.initState();
    obtenerUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Bienvenido",
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Color(0xFF0B8FAC),
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/sanateclogo.png',
              width: 130,
            ), //no se porque aparece una linea verde abajo cuando lo ves en web
            const SizedBox(height: 15),
            const Text(
              "Iniciar sesión",
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.black,
                fontSize: 27,
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
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text(
                  "Teléfono",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0x80858585)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0x80858585)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0x80858585)),
                  ),
                  filled: true,
                  fillColor: const Color(0x40D9D9D9),
                  hintText: "Ingrese su teléfono", // Placeholder
                  hintStyle: const TextStyle(color: Colors.grey),
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
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text(
                  "Contraseña",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0x80858585)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0x80858585)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0x80858585)),
                  ),
                  filled: true,
                  fillColor: const Color(0x40D9D9D9),
                  hintText: "Ingrese su contraseña",
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultarContra ? Icons.visibility_off : Icons.visibility,
                    ),
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
                obscuringCharacter: "•",

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    _validarLogin(); //la funcion se encuentra abajo
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B8FAC),
                    padding: const EdgeInsets.symmetric(horizontal: 127, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Ingresar",
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => sign()),
                  );
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
          ],
        ),
      ),
    );
  }

  Future<void> _validarLogin() async {  //Valida los datos ingresados comparándolos con los usuarios de la lista. Si los datos son correctos, guarda la sesión y navega a la pantalla de inicio. Si no coinciden, muestra un mensaje de error.
    for (final usuario in usuarios) {
      if (usuario['telefono'] == _telefonoRe &&
          usuario['pass'] == _contrasenaRe) {
        await saveSessionData({
          'nombre': usuario['nom_user'],
          'telefono': usuario['telefono'],
          'contra': usuario['pass'],
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Inicio()),
        );
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Telefono o Contraseña incorrectas')),
    );
  }
}