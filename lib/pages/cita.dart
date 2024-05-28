import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/db/citas.dart';
import 'package:proyecto_consultorio/pages/confirmacionCita.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../utils/storage.dart';

class Cita extends StatefulWidget {
  final List<Map<String, dynamic>> doctors;

  Cita({required this.doctors});

  @override
  _CitaState createState() => _CitaState();
}

class _CitaState extends State<Cita> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  bool citaRegistrada = false;
  List<String> timeSlots = [];
  int? _selectedTimeIndex;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now().add(const Duration(days: 3));
    _selectedTimeIndex = null;
    _setConection();
  }

  Future<void> _setConection() async {
    await CitasDB.conecctCitas();
    _getCitas(DateFormat('dd-MM-yyyy').format(_selectedDay));
  }

  Future<void> _getCitas(String fecha) async {
    Map<String, dynamic> datosusuario = await getSessionData();
    String nombrePac = datosusuario['nombre'];
    String nombreDoc = widget.doctors[0]['name'];
    bool citaExistente = await CitasDB.getCitasDocUser(nombreDoc, nombrePac);
    setState(() {
      citaRegistrada = citaExistente;
    });
    if (!citaRegistrada) {
      final citas = await CitasDB.getCitasFecha(fecha, nombreDoc);
      if (citas.isNotEmpty) {
        setState(() {
          timeSlots.clear();
          List<String> horas = citas.map((cita) => cita['hr_cita'] as String).toList();
          _generateVariableTimeSlots(horas);
        });
      } else {
        setState(() {
          timeSlots.clear();
          _generateTimeSlots();
        });
      }
    }
  }

  void _generateVariableTimeSlots(List<String> horas) {
    DateTime startTime = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day, 9, 0);
    DateTime endTime = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day, 16, 0);

    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      String formattedTime = '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} ${startTime.hour < 12 ? 'AM' : 'PM'}';
      if (!horas.contains(formattedTime)) {
        timeSlots.add(formattedTime);
      }
      startTime = startTime.add(const Duration(minutes: 30));
    }
  }

  Future<void> _registrarCita() async {
    if (_selectedTimeIndex == null) {
      return;
    }
    Map<String, dynamic> datosusuario = await getSessionData();
    Map<String, dynamic> infoCita = {
      'nom_user': datosusuario['nombre'],
      'nom_doctor': widget.doctors[0]['name'],
      'fecha': DateFormat('dd-MM-yyyy').format(_selectedDay),
      'hr_cita': timeSlots[_selectedTimeIndex!],
      'estado': 'Pendiente'
    };
    try {
      await CitasDB.coleccionCitas.insertOne(infoCita);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => confirmacionCita(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al registrar la cita"),
          backgroundColor: Colors.red,
        ),
      );
      print("Error al registrar la cita: $e");
    }
  }

  void _generateTimeSlots() {
    DateTime startTime = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day, 9, 0);
    DateTime endTime = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day, 16, 0);
    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      timeSlots.add(
          '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} ${startTime.hour < 12 ? 'AM' : 'PM'}');
      startTime = startTime.add(const Duration(minutes: 30));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cita",
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.doctors[0]["foto"],
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
                        widget.doctors[0]['name'],
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.doctors[0]['specialty'],
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          color: const Color(0xFF7BC1B7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Consulta ',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${widget.doctors[0]['consultation_fee']}.00',
                              style: const TextStyle(
                                color: Color(0xFF7BC1B7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2026, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (selectedDay.isAfter(DateTime.now().add(const Duration(days: 2)))) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = selectedDay;
                      _selectedTimeIndex = null;
                      if (!citaRegistrada) {
                        _getCitas(DateFormat('dd-MM-yyyy').format(_selectedDay));
                      }
                    });
                  }
                },
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF0B8FAC),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Color(0x400B8FAC),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Colors.black),
                  markerDecoration: BoxDecoration(
                    color: Color(0xFF0B8FAC),
                    shape: BoxShape.circle,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Color(0xFF0B8FAC),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Horarios disponibles',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              if (citaRegistrada)
                Text(
                  'Ya tienes una cita registrada con este doctor.',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      timeSlots.length,
                          (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTimeIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _selectedTimeIndex == index
                                ? const Color(0xFF0B8FAC)
                                : const Color(0x40D9D9D9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              timeSlots[index],
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: _selectedTimeIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: citaRegistrada ? null : _registrarCita,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B8FAC),
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
