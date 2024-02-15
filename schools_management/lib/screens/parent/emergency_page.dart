import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schools_management/animation/FadeAnimation.dart';
import 'package:schools_management/helper/get_helper.dart';
import 'package:schools_management/widgets/parent/emergency_tile.dart';

class Emergency extends StatefulWidget {
  final String studentId;

  Emergency({required this.studentId});

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  var emergency;

  @override
  void initState() {
    emergency = GetHelper.getData(widget.studentId, 'get_student_emergency', 'id');
    super.initState();
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
                        "Emergency",
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
                child: FutureBuilder(
                  future: emergency,
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (!snapshots.hasData || snapshots.data == null) {
                      return Center(
                        child: Text(
                          'No People Added Right now',
                          style: GoogleFonts.antic(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshots.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return EmergencyTile(
                            relation: snapshots.data?[index]['relation'] ?? '',
                            name: snapshots.data?[index]['name'] ?? '',
                            address: snapshots.data?[index]['address'] ?? '',
                            email: snapshots.data?[index]['email'] ?? '',
                            number: snapshots.data?[index]['number'] ?? '',
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
