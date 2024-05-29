import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/db/citas.dart';
import 'package:proyecto_consultorio/pages/citaAgendada.dart';

import '../utils/storage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> citas = [];

  @override
  void initState() {
    super.initState();
    _loadCitas();
  }

  _loadCitas() async {
    Map<String, dynamic> datosusuario = await getSessionData();
    await CitasDB.conecctCitas();
    final nuevasCitas = await CitasDB.getCitasUsuario(datosusuario['nombre']);
    if (mounted) {
      setState(() {
        citas = nuevasCitas;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 30, right: 10),
            child: Text(
              "Historial",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: citas.length,
            itemBuilder: (context, index) {
              final cita = citas.reversed.toList()[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CitaAgendada(doctorData: cita),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, right: 15),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(210, 235, 231, .3),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(),
                          child: const Icon(
                            Icons.notifications_none,
                            size: 35,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cita["fecha"] ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Hora: ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(133, 133, 133, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: cita["hr_cita"] ?? '',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(133, 133, 133, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 64,
                          height: 80,
                          alignment: Alignment.topLeft,
                          decoration: const BoxDecoration(),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 18.5),
                            child: Text(
                              "30 Min",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}