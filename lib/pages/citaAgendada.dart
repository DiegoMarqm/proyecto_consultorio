import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/pages/cancelacionCita.dart';
import 'package:proyecto_consultorio/db/citas.dart';

import '../db/medicos.dart';

class CitaAgendada extends StatefulWidget {
  final Map<String, dynamic>? doctorData;

  const CitaAgendada({Key? key, this.doctorData}) : super(key: key);

  @override
  State<CitaAgendada> createState() => _CitaAgendadaState();
}

class _CitaAgendadaState extends State<CitaAgendada> {
  Map<String, dynamic>? doctorInfo;
  bool citaPendeiente = true;
  @override
  void initState() {
    super.initState();
    _loadDoctorInfo();
  }

  _loadDoctorInfo() async {
    var doctorList = await MedicosDB.getMedicoInfo(widget.doctorData?['nom_doctor']);
    if (doctorList.isNotEmpty) {
      setState(() {
        doctorInfo = doctorList[0];
      });
    }
    if(widget.doctorData?['estado']!='Pendiente'){
      setState(() {
        citaPendeiente = false;
      });
    }
  }
_checkState(){
    if(widget.doctorData?['estado']=='Pendiente'){
      CitasDB.cancelarCita(widget.doctorData?['nom_doctor'], widget.doctorData?['fecha'], widget.doctorData?['hr_cita']);
      return true;
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cita agendada",
          style: GoogleFonts.openSans(
            color: const Color(0xFF0B8FAC),
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2EBE7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          color: const Color(0x40D9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            doctorInfo?['foto']?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorData?['nom_doctor'] ?? '',
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        doctorInfo?['especialidad']?? '',
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          color: const Color(0xFF7BC1B7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text: 'Consulta ',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\$',
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: const Color(0xFF7BC1B7),
                              ),
                            ),
                            TextSpan(
                              text: doctorInfo?['costo']?? '',
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: const Color(0xFF7BC1B7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // Contenido adicional
              Text(
                'Día',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0x80D9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.doctorData?['fecha'] ?? '',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Hora',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0x80D9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.doctorData?['hr_cita'] ?? '',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Estado',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0x80D9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.doctorData?['estado'] ?? '',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: Column(
                  children: <Widget>[
                    citaPendeiente
                        ? ElevatedButton(
                      onPressed: () {
                        if (_checkState()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cancelacionCita(),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF7BC1B7).withOpacity(0.75),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Cancelar Cita',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                        : Container(), // Si la cita no está pendiente, no se muestra el botón
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF0B8FAC),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(horizontal: 123, vertical: 16),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'Aceptar',
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}