import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schools_management/animation/FadeAnimation.dart';
import 'package:schools_management/helper/get_helper.dart';
import 'package:schools_management/widgets/parent/activity_tile.dart';

class Activities extends StatefulWidget {
  final String studentId;

  Activities({required this.studentId});

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  late Future activities; // Declare activities as late Future

  @override
  void initState() {
    activities = GetHelper.getData(widget.studentId, 'get_student_activities', 'id');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromRGBO(154, 233, 178, 1),
              Color.fromRGBO(173, 187, 238, 1),
            ])),
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
                            "Activities",
                            style: GoogleFonts.antic(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              fontSize: 40,
                            ),
                          ))),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100))),
                padding: EdgeInsets.all(20),
                child: FutureBuilder(
                  future: activities,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.length == 0) {
                      return Center(
                          child: Text('No Activities Right now',
                              style: GoogleFonts.antic(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ActivityTile(
                            name: snapshot.data![index]['name'],
                            explanation: snapshot.data![index]['explanation'],
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
