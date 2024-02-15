import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:schools_management/screens/parent/main_parent_page.dart';
import 'package:schools_management/screens/teacher/main_teacher_page.dart';

class GetHelper {
  static Future<void> sendComplant(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String type,
      String name,
      String number,
      String title,
      String feedback,
      String schoolId,
      ) async {
    if (formKey.currentState!.validate()) {
      try {
        // Construct the data to be sent
        var data = {
          'school_id': schoolId,
          'type': type,
          'name': name,
          'number': number,
          'title': title,
          'feedback': feedback,
        };

        // Send the data
        var response = await http.post(
          Uri.parse("http://10.0.2.2/institutions/for_app/insert_data/insert_complant.php"),
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          var message = jsonDecode(response.body);
          print(message);

          // Show a dialog to inform the user
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text('Thanks')),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Center(
                          child: FlatButton(
                            child: Text("Ok"),
                            color: Colors.blueAccent,
                            onPressed: () {
                              Navigator.of(context).pushNamed(MainParentPage.routeName);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> sendTask(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String schoolId,
      String groupId,
      String subject,
      String task,
      ) async {
    if (formKey.currentState!.validate()) {
      try {
        // Construct the data to be sent
        var data = {
          'school_id': schoolId,
          'group_id': groupId,
          'subject': subject,
          'task': task,
        };

        // Send the data
        var response = await http.post(
          Uri.parse("http://10.0.2.2/institutions/for_app/insert_data/insert_task.php"),
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          var message = jsonDecode(response.body);
          print(message);

          // Show a dialog to inform the user
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text('Thanks')),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Center(
                          child: FlatButton(
                            child: Text("Ok"),
                            color: Colors.blueAccent,
                            onPressed: () {
                              Navigator.of(context).pushNamed(MainTeacherPage.routeName);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
