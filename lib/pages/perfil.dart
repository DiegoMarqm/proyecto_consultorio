import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/pages/cambiarContra.dart';
import 'package:proyecto_consultorio/pages/login.dart';

import '../utils/storage.dart';

class perfil extends StatefulWidget {  //perfil es un StatefulWidget porque su estado puede cambiar durante la ejecución de la aplicación. Esto es necesario porque los datos del usuario se cargan de manera asíncrona.
  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {  //Lista de datos del usuario, inicialmente con valores predeterminados.
  List<Map<String, dynamic>> userData = [
    {'value': 'Luis Gomez Perez', 'icon': Icons.person},
    {'value': '4812635968', 'icon': Icons.phone},
  ];
  @override
  void initState() {  //Método que se llama cuando el widget se inserta en el árbol de widgets. Llama a _loadData para cargar los datos del usuario.
    super.initState();
    _loadData();
  }
  Future<void> _loadData() async {  // Método asíncrono que obtiene los datos del usuario de la sesión y actualiza el estado.
    Map<String, dynamic> datosusuario = await getSessionData();
    if (datosusuario.isNotEmpty) {
      setState(() {
        userData[0]['value'] = datosusuario['nombre'];
        userData[1]['value'] = datosusuario['telefono'];
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 40.0, 40.0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Perfil',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              for (var data in userData)  //Itera sobre userData y muestra cada dato del usuario en una fila con un ícono y texto.
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD2EBE7),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              data['icon'],
                              size: 40,
                              color: const Color(0xFF0B8FAC),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['value'],
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => changePass()),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD2EBE7),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.lock,
                          size: 40,
                          color: Color(0xFF0B8FAC),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cambiar contraseña',
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 90),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    deleteSessionData();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B8FAC),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 87,
                      vertical: 16,
                    ),
                    disabledBackgroundColor: const Color(0xFF0B8FAC),
                    disabledForegroundColor: Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(  //Al presionarlo, se elimina la información de sesión y se redirige al usuario a la página de inicio de sesión.
                    'Cerrar sesión',
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
      ),
    );
  }
}