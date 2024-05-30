import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_consultorio/db/citas.dart';
import 'package:proyecto_consultorio/pages/citaAgendada.dart';

import '../utils/storage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> citas = [];  //Lista de citas del usuario
  bool isLoading = true;

  @override
  void initState() {  //Método llamado al crear el estado del widget. Inicializa la carga de citas
    super.initState();
    _loadCitas();
  }


  String convertirFecha(String fechaStr) {
    // Diccionario para los nombres de los meses en español
    const Map<int, String> meses = {
      1: "Enero", 2: "Febrero", 3: "Marzo", 4: "Abril",
      5: "Mayo", 6: "Junio", 7: "Julio", 8: "Agosto",
      9: "Septiembre", 10: "Octubre", 11: "Noviembre", 12: "Diciembre"
    };

    // Parsear la fecha en el formato dd-MM-yyyy
    DateTime fecha = DateFormat('dd-MM-yyyy').parse(fechaStr);

    // Extraer día, mes y año
    int dia = fecha.day;
    String mes = meses[fecha.month]!;
    int anio = fecha.year;

    // Formatear la fecha en el nuevo formato
    return '$dia de $mes del $anio';
  }


  _loadCitas() async {  //Método asíncrono que carga las citas del usuario desde la base de datos. Utiliza getSessionData para obtener los datos del usuario, conecta a la base de datos y obtiene las citas del usuario.
    Map<String, dynamic> datosusuario = await getSessionData();
    isLoading = true;
    await CitasDB.conecctCitas();
    final nuevasCitas = await CitasDB.getCitasUsuario(datosusuario['nombre']);
    if (mounted) {
      setState(() {
        citas = nuevasCitas;
      });
    }
    setState(() {
      isLoading =
      false; // Oculta la animación de carga al finalizar la carga de médicos
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isLoading
            ? [ const Column(
            children:[
              SizedBox(height: 250),
              Center(child: CircularProgressIndicator())] )]
            :[
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
              final cita = citas.reversed.toList()[index];  // Invierte el orden de las citas para mostrar las más recientes primero.

              Color iconColor;
              if(cita['estado'] == 'Pendiente') {
                iconColor = Colors.green;
              } else if(cita['estado']== 'Atendida'){
                iconColor = Colors.blue;
              }else{
                iconColor = Colors.red;
              }

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
                          child: Icon(
                            Icons.notifications_none,
                            size: 35,
                            color: iconColor,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                convertirFecha(cita["fecha"]) ?? '',
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