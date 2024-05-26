import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';

class changePass extends StatefulWidget{
  @override
  State<changePass> createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  bool _ocultarContra = true;

  @override
  Widget build(BuildContext context){
    return  Scaffold(
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
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Para garantizar la seguridad de tu cuenta, te recomendamos cambiar tu contraseña regularmente.",
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
              padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
              child: Text("Por favor, ingresa la nueva contraseña que deseas utilizar.",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Color(0xFF646464),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Nueva contraseña",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x40858585)),
                ),
                filled: true,
                fillColor: const Color(0x40D9D9D9),
                hintText: "Ingrese su nueva contraseña",
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(_ocultarContra ? Icons.visibility_off : Icons.visibility),
                  color: const Color(0xFF0B8FAC),
                  onPressed: (){
                    setState((){
                      _ocultarContra = !_ocultarContra;
                    }
                    );
                  },
                ),
              ),
              obscureText: _ocultarContra,
              obscuringCharacter: "*",
            ),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Confirmación de contraseña",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x40858585)),
                ),
                filled: true,
                fillColor: const Color(0x40D9D9D9),
                hintText: "Confirme la nueva contraseña",
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(_ocultarContra ? Icons.visibility_off : Icons.visibility),
                  color: const Color(0xFF0B8FAC),
                  onPressed: (){
                    setState((){
                      _ocultarContra = !_ocultarContra;
                    }
                    );
                  },
                ),
              ),
              obscureText: _ocultarContra,
              obscuringCharacter: "*",
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(onPressed: () {  },
              child: Text(
                "Aceptar",
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B8FAC),
                padding:
                const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}