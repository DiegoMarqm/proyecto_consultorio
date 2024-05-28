import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/pages/cambiarContra.dart';
import 'package:proyecto_consultorio/pages/login.dart';

import '../utils/storage.dart';

class perfil extends StatefulWidget {
  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  List<Map<String, dynamic>> userData = [
    {'value': 'Luis Gomez Perez', 'icon': Icons.person},
    {'value': '4812635968', 'icon': Icons.phone},
    {'value': 'Contraseña', 'icon': Icons.remove_red_eye},
  ];
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  Future<void> _loadData() async {
    // Recuperar datos de usuario del almacenamiento
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
              for (var data in userData)
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
                  child: Text(
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