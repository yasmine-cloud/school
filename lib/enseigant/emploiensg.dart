import 'package:flutter/material.dart';
import 'package:school/API/PareXML.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:school/API/classes.dart';
import 'package:school/API/httpreq.dart';
import 'package:intl/intl.dart';


class Emploiensg extends StatefulWidget {
  @override
  State<Emploiensg> createState() => _EmploiensgState();
}

class _EmploiensgState extends State<Emploiensg> {
  List<Appointment> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEmplois();
  }
  // Fonction pour formater l'heure
String formatTime(DateTime time) {
  final DateFormat formatter = DateFormat('HH:mm'); // Format 24 heures
  return formatter.format(time);
}

Future<void> _fetchEmplois() async {
  try {
    // Appel à l'API pour récupérer les données XML
    final emplois = await THttpHelper.get<Emploi>(
      'GetEmploi', // Remplacez par le nom exact de votre endpoint
      queryParameters: {'numcin': '01010101'},
      parseEmploiList,
    );

    // Afficher les emplois récupérés dans la console
    print('Emplois récupérés: $emplois');

    // Transformer les emplois en objets Appointment pour le calendrier
    setState(() {
      _appointments = emplois.map((emploi) {
        DateTime startTime = _adjustDateForDay(emploi.jour, emploi.hrdeb);
        DateTime endTime = _adjustDateForDay(emploi.jour, emploi.hrfin);
        print('Start time: $startTime, End time: $endTime');  // Check the times


        return Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: '${emploi.Jour1} - ${emploi.Matiere}  ',
          location: emploi.salle,
          color: Colors.green,
          
        );
      }).toList();
      _isLoading = false;
    });
  } catch (e) {
    print('Erreur lors du chargement des emplois : $e');
    setState(() {
      _isLoading = false;
    });
  }
}

  DateTime _adjustDateForDay(int jour, String time) {
    final DateTime today = DateTime.now();
    final daysToAdd = (jour - today.weekday + 7) % 7;
    final targetDate = today.add(Duration(days: daysToAdd));
    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    return DateTime(targetDate.year, targetDate.month, targetDate.day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
          child: Text(
            "Emploi du Temps",
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SfCalendar(
            
              backgroundColor: Colors.white,
              view: CalendarView.week,
              weekNumberStyle: WeekNumberStyle(backgroundColor: Colors.amber),
              firstDayOfWeek: 1,
              todayHighlightColor: Colors.lightBlue,
              headerStyle: const CalendarHeaderStyle(textStyle: TextStyle(color: Colors.white, fontSize: 20), backgroundColor: Colors.lightBlue),
              dataSource: MeetingDataSource(_appointments),

              onTap: (details) {
                if (details.appointments != null) {
                 showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text(
        details.appointments![0].subject,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Afficher l'heure au format hh:mm
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.lightBlueAccent),
              const SizedBox(width: 8),
              Text(
                'De ${formatTime(details.appointments![0].startTime)} à ${formatTime(details.appointments![0].endTime)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.lightBlueAccent),
              const SizedBox(width: 8),
              Text(
                'Salle: ${details.appointments![0].location}',
                style: const TextStyle(fontSize: 16),
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
    );
  }
}

// DataSource pour le calendrier
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
