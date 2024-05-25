import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class citaAgendada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cita Agendada',style: TextStyle(color:Colors.blue),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDoctorInfo(),
              SizedBox(height: 20),
              _buildDateTimeInfo(),
              SizedBox(height: 20),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/house.jpg')
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Gregory House',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Nefrología e infectología',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Consulta 1200',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateTimeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Día',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(width: 20),
        Text(
          '24-mayo-2024',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Hora',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(width: 20),
        Text(
          '9:00 am',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Estado',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(width: 20),
        Text(
          'Agendada',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {

          },
          child: Text('Cancelar Cita'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            minimumSize: Size(200, 50),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {

          },
          child: Text('Aceptar'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            minimumSize: Size(200, 50),
          ),
        ),
      ],
    );
  }
}


