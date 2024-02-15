import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schools_management/animation/FadeAnimation.dart';
import 'package:schools_management/helper/get_helper.dart';
import 'package:schools_management/widgets/parent/feedback_tile.dart';

class StudentFeedback extends StatefulWidget {
  final String studentId;

  StudentFeedback({required this.studentId});

  @override
  _StudentFeedbackState createState() => _StudentFeedbackState();
}

class _StudentFeedbackState extends State<StudentFeedback> {
  late Future<List<Map<String, dynamic>>> feedbacks;

  @override
  void initState() {
    feedbacks = GetHelper.getData(
        widget.studentId, 'get_student_feedback', 'id');
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
                        "Feedbacks",
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
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                  ),
                ),
                padding: EdgeInsets.all(20),
                child: FutureBuilder(
                  future: feedbacks,
                  builder: (context, AsyncSnapshot<dynamic> snapshots) {
                    if (!snapshots.hasData ||
                        snapshots.data == null ||
                        snapshots.data.length == 0) {
                      return Center(
                        child: Text(
                          'No Feedbacks Right now',
                          style: GoogleFonts.antic(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshots.data.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data[index];
                        if (data == null) return Container(); // Add null check
                        return FeedbackTile(
                          subject: data['subject'],
                          feedback: data['feedback'],
                          teacherName: data['teacher_name'],
                          dateOfFeedback: data['date_of_feedback'],
                        );
                      },
                    );
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
