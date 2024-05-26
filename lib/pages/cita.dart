import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class cita extends StatefulWidget {
  @override
  _citaState createState() => _citaState();
}

class _citaState extends State<cita> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  int? _selectedTimeIndex;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now()
        .add(const Duration(days: 3));
    _selectedTimeIndex = null;
  }

  List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    DateTime startTime =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day, 9, 0);
    DateTime endTime = DateTime(
        _selectedDay.year, _selectedDay.month, _selectedDay.day, 16, 0);

    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      timeSlots.add(
          '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} ${startTime.hour < 12 ? 'AM' : 'PM'}');
      startTime = startTime.add(const Duration(minutes: 30));
    }

    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = _generateTimeSlots();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: Text(
            'Cita',
            style: GoogleFonts.openSans(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B8FAC),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
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
                  const ColoredContainer(),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Daniel',
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Pediatría',
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
                              text: '\$120.00',
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
              const SizedBox(height: 20),
              TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2026, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (selectedDay
                      .isAfter(DateTime.now().add(const Duration(days: 2)))) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          selectedDay;
                      _selectedTimeIndex = null;
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
                  onPressed: _selectedTimeIndex != null
                      ? () {
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0B8FAC),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 16),
                    disabledBackgroundColor:
                        const Color(0xFF0B8FAC),
                    disabledForegroundColor: Colors.white
                        .withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Aceptar',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white,
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

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.asset(
              'assets/doctor.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}