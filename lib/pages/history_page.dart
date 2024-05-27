import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/pages/citaAgendada.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> citas = [
      {
        "fecha": "21 de mayo 2024",
        "hora": "9:00 am",
      },
      {
        "fecha": "22 de mayo 2024",
        "hora": "10:00 am",
      },
      {
        "fecha": "23 de mayo 2024",
        "hora": "11:00 am",
      },
      {
        "fecha": "24 de mayo 2024",
        "hora": "12:00 pm",
      },
      {
        "fecha": "25 de mayo 2024",
        "hora": "1:00 pm",
      },
      {
        "fecha": "26 de mayo 2024",
        "hora": "2:00 pm",
      },
      {
        "fecha": "27 de mayo 2024",
        "hora": "3:00 pm",
      },
      {
        "fecha": "28 de mayo 2024",
        "hora": "4:00 pm",
      },
      {
        "fecha": "29 de mayo 2024",
        "hora": "5:00 pm",
      },
      {
        "fecha": "30 de mayo 2024",
        "hora": "6:00 pm",
      },
    ];

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
            // Lista de citas
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: citas.length,
              itemBuilder: (context, index) {
                final cita = citas[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CitaAgendada()),
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
                                  cita["fecha"]!,
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
                                        text: cita["hora"]!,
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
