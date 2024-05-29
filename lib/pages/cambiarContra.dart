import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/db/usuarios.dart';
import 'package:proyecto_consultorio/pages/exitoContra.dart';
import 'package:proyecto_consultorio/utils/storage.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class changePass extends StatefulWidget {
  @override
  State<changePass> createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  bool _ocultarContra = true;
  bool _ocultarContra2 = true;

  final _contra1 = TextEditingController();
  final _contra2 = TextEditingController();

  String _contra = '';
  String _usuario = '';


  @override
  void initState(){
    super.initState();
    _contraActual();
    _setConection();
  }

  Future<void> _setConection() async {
    await UserDB.conecctUsers();
  }

  Future<void> _contraActual() async{
    Map<String, dynamic> userContra = await getSessionData();
    if (userContra.isNotEmpty){
      setState(() {
        _contra = userContra['contra'];
        _usuario = userContra['nombre'];
      });
    }
  }

  Future<bool> _checarContra() async {
    String contra1 = _contra1.text;
    String contra2 = _contra2.text;

    if (contra1.isEmpty || contra2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Por favor llene todos los campos")));
      return false;
    } else {
      if (contra1 != contra2) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Contraseñas no coinciden")));
        return false;
      }
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cambiar contraseña",
          style: GoogleFonts.openSans(
            color: const Color(0xFF0B8FAC),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text(
                  "Para garantizar la seguridad de tu cuenta, te recomendamos cambiar tu contraseña regularmente.",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Color(0xFF646464),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text(
                  "Por favor, ingresa la nueva contraseña que deseas utilizar.",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Color(0xFF646464),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                  child: Text(
                    'Contraseña actual',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                  //enabled: false,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
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
                  hintText: _contra,
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                //readOnly: true,
                enabled: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                  child: Text(
                    "Nueva contraseña",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
              child: TextField(
                controller: _contra1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
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
                  hintText: "Ingrese su nueva contraseña",
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
                obscuringCharacter: "•",
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                  child: Text(
                    "Confirmación de contraseña",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
              child: TextField(
                controller: _contra2,
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
                  hintText: "Confirme la nueva contraseña",
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(_ocultarContra2
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: const Color(0xFF0B8FAC),
                    onPressed: () {
                      setState(() {
                        _ocultarContra2 = !_ocultarContra2;
                      });
                    },
                  ),
                ),
                obscureText: _ocultarContra2,
                obscuringCharacter: "•",
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if(await _checarContra()){
                    UserDB.updateContra(_usuario, _contra1.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => exitoContra(),
                      ),
                    );
                  }
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
                  "Aceptar",
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
