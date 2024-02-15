import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schools_management/animation/FadeAnimation.dart';
import 'package:schools_management/helper/get_helper.dart';
import 'package:schools_management/widgets/parent/fees_tile.dart';

class Fees extends StatefulWidget {
  final String studentId;

  Fees({required this.studentId});

  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  var fees;
  double total = 0;

  @override
  void initState() {
    super.initState();
    total = 0;
    if (widget.studentId == null) {
      // Handle null studentId here
    } else {
      fees = GetHelper.getData(
          widget.studentId, 'get_student_fees', 'id');
    }
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
                        "Fees",
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
                  future: fees,
                  builder: (context, snapshots) {
                    if (!snapshots.hasData) {
                      return Center(
                        child: Text(
                          'No Feed backs Right now',
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshots.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (!snapshots.hasData ||
                            snapshots.data.length == 0) {
                          return Center(
                              child: Text('No Fees Right now',
                                  style: GoogleFonts.antic(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)));
                        }
                        total += double.parse(
                            snapshots.data[index]['fees_amount'].toString());
                        print(total);

                        return FeesTile(
                          amount: snapshots.data[index]['fees_amount'].toString(),
                          date: snapshots.data[index]['date_of_pay'].toString(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            BottomAppBar(
              child: ListTile(
                leading: Icon(
                  Icons.attach_money,
                  color: Colors.green,
                  size: 50,
                ),
                title: Text('Total :',
                    style: GoogleFonts.antic(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                onTap: () {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Center(child: Text('Total')),
                      content: Container(
                        height: 150,
                        child: Center(
                          child: Text(
                            '$total \$',
                            style: GoogleFonts.antic(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                subtitle: Text('Press to show total'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
