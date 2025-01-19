import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmploiEtudiant extends StatefulWidget {
  @override
  State<EmploiEtudiant> createState() => _EmploiEtudiantState();
}

class _EmploiEtudiantState extends State<EmploiEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
          child: Text(
            "Emploi du Temps Étudiant",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SfCalendar(
            view: CalendarView.week,
            firstDayOfWeek: 1,
            todayHighlightColor: Colors.blue,
            headerStyle: const CalendarHeaderStyle(
              textStyle: TextStyle(color: Colors.white, fontSize: 20),
              backgroundColor: Colors.lightBlue,
            ),
            dataSource: MeetingDataSource(getCoursEtudiant()),
            onTap: (details) {
              if (details.appointments != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        details.appointments![0].subject,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.lightBlue),
                              const SizedBox(width: 8),
                              Text(
                                'De ${formatDateTime(details.appointments![0].startTime)} à ${formatDateTime(details.appointments![0].endTime)}',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.lightBlue),
                              const SizedBox(width: 8),
                              Text(
                                'Salle : ${details.appointments![0].location}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

String formatDateTime(DateTime dateTime) {
  return "${dateTime.hour}:${dateTime.minute < 10 ? '0' + dateTime.minute.toString() : dateTime.minute}";
}

List<Appointment> getCoursEtudiant() {
  List<Appointment> courses = <Appointment>[];
  final DateTime today = DateTime.now();

  courses.add(Appointment(
    startTime: DateTime(today.year, today.month, today.day, 8, 0),
    endTime: DateTime(today.year, today.month, today.day, 10, 0),
    subject: 'Mathématiques - Salle 201',
    location: 'Salle 201',
    color: Colors.green,
  ));

  courses.add(Appointment(
    startTime: DateTime(today.year, today.month, today.day, 11, 0),
    endTime: DateTime(today.year, today.month, today.day, 12, 30),
    subject: 'Physique - Salle 202',
    location: 'Salle 202',
    color: Colors.orange,
  ));

  courses.add(Appointment(
    startTime: DateTime(today.year, today.month, today.day + 1, 9, 0),
    endTime: DateTime(today.year, today.month, today.day + 1, 11, 0),
    subject: 'Anglais - Salle 203',
    location: 'Salle 203',
    color: Colors.blue,
  ));

  return courses;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
