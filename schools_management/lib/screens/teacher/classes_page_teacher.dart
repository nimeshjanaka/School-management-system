import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schools_management/animation/FadeAnimation.dart';
import 'package:schools_management/helper/get_helper.dart';
import 'package:schools_management/screens/teacher/task_page.dart';
import 'package:schools_management/widgets/teacher/group_tile_teacher.dart';

class TeacherClasses extends StatefulWidget {
  final String teacherId;
  final String schoolId;

  TeacherClasses({required this.teacherId, required this.schoolId});

  @override
  _TeacherClassesState createState() => _TeacherClassesState();
}

class _TeacherClassesState extends State<TeacherClasses> {
  late Future<List<Map<String, dynamic>>> groups;

  @override
  void initState() {
    super.initState();
    groups = GetHelper.getData(
        widget.teacherId, 'get_teacher_groups', 'teacher_id');
  }

  // go to task page
  void goTaskForm(String groupId, String schoolId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskPage(
          groupId: groupId,
          schoolId: schoolId,
        ),
      ),
    );
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
                        "Classes",
                        style: GoogleFonts.antic(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
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
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(100))),
                padding: EdgeInsets.all(20),
                // Using FutureBuilder to show the data in a list view
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: groups,
                  builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshots.hasData || snapshots.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No Classes Right now',
                          style: GoogleFonts.antic(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshots.data!.length,
                        itemBuilder: (context, index) {
                          return GroupTeacherTile(
                            name: snapshots.data![index]['name'],
                            subject: snapshots.data![index]['subject'],
                            time: snapshots.data![index]['time_of_room'],
                            function: () => goTaskForm(
                                snapshots.data![index]['id'], widget.schoolId),
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
