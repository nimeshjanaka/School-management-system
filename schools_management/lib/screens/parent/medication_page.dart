import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schools_management/animation/FadeAnimation.dart';
import 'package:schools_management/helper/get_helper.dart';
import 'package:schools_management/widgets/parent/medication_tile.dart';

class Medication extends StatefulWidget {
  final String studentId;

  Medication({required this.studentId});

  @override
  _MedicationState createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  late Future<List<Map<String, dynamic>>> medications;

  @override
  void initState() {
    super.initState();
    medications = GetHelper.getData(widget.studentId, 'get_student_medication', 'id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(154, 233, 178, 1),
              Color.fromRGBO(173, 187, 238, 1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: FadeAnimation(
                      1.3,
                      Text(
                        "Medication",
                        style: GoogleFonts.antic(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
                ),
                padding: EdgeInsets.all(20),

                // FutureBuilder to show the data in a list view
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: medications,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No Medication Cases Right now',
                          style: GoogleFonts.antic(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final medication = snapshot.data![index];
                          return MedicationTile(
                            name: medication['name'] ?? '',
                            description: medication['description'] ?? '',
                            time: medication['time_of_treatment'] ?? '',
                            dateofRegister: medication['date_of_register'] ?? '',
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
