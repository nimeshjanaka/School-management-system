import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schools_management/animation/FadeAnimation.dart';
import 'package:schools_management/helper/get_helper.dart';
import 'package:schools_management/widgets/parent/student_tables.dart';

class TablePage extends StatefulWidget {
  final String studentGrade;

  TablePage({required this.studentGrade});

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  late Future<List<Map<String, dynamic>>> table;

  @override
  void initState() {
    super.initState();
    table = GetHelper.getData(
        widget.studentGrade, 'get_student_table', 'grade');
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
                        "Table",
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
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: table,
                  builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshots.hasData || snapshots.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No Tables Added Right now',
                          style: GoogleFonts.antic(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshots.data!.length,
                        itemBuilder: (context, index) {
                          return TableTile(
                            appoint1: snapshots.data![index]['appointment1'],
                            appoint2: snapshots.data![index]['appointment2'],
                            appoint3: snapshots.data![index]['appointment3'],
                            appoint4: snapshots.data![index]['appointment4'],
                            appoint5: snapshots.data![index]['appointment5'],
                            appoint6: snapshots.data![index]['appointment6'],
                            appoint7: snapshots.data![index]['appointment7'],
                            appoint8: snapshots.data![index]['appointment8'],
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
