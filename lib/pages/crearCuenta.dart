import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_consultorio/db/usuarios.dart';
import 'package:proyecto_consultorio/pages/login.dart';

class sign extends StatefulWidget {
  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  bool _ocultarContra = true;

  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  Future<void> _registrarUsuario() async {
    String nombre = _nombreController.text;
    String telefono = _telefonoController.text;
    String contrasena = _contrasenaController.text;

    if (nombre.isEmpty || telefono.isEmpty || contrasena.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor llene todos los campos"),
        ),
      );
      return;
    }

    Map<String, dynamic> usuario = {
      "nom_user": nombre,
      "telefono": telefono,
      "pass": contrasena,
    };

    try {
      await MongoDB.coleccionUsuarios.insertOne(usuario);
      _nombreController.clear();
      _telefonoController.clear();
      _contrasenaController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario Registrado con exito"),
          backgroundColor: Colors.green,
        ),
      );
      print("Usuario Registrado");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al registrar el usuario"),
          backgroundColor: Colors.red,
        ),
      );
      print("Error al registrar el usuario: $e");
    }
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
              "Crea una cuenta",
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Color(0xFF0B8FAC),
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Image.asset(
              'assets/sanatec.jpg',
              width: 130,
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                  child: Text(
                    "Nombre",
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
                controller: _nombreController,
                keyboardType: TextInputType.text,
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
                  hintText: "Ingrese su nombre",
                  hintStyle: const TextStyle(color: Colors.grey),
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
                controller: _telefonoController,
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
                  hintText: "Ingrese su teléfono",
                  hintStyle: const TextStyle(color: Colors.grey),
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
                controller: _contrasenaController,
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
                    icon: Icon(_ocultarContra
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: const Color(0xFF0B8FAC),
                    onPressed: () {
                      setState(() {
                        _ocultarContra = !_ocultarContra;
                      });
                    },
                  ),
                ),
                obscureText: _ocultarContra,
                obscuringCharacter: "*",
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  _registrarUsuario();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B8FAC),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
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
          ],
        ),
      ),
    );
  }
}
