import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class StudentInf {
  final String? id;
  final String? schoolID;
  final String? name;
  final String? grade;
  final String? address;
  final String? dateOfBirth;
  final String? dateOfRegister;

  StudentInf({
    this.id,
    this.schoolID,
    this.name,
    this.grade,
    this.address,
    this.dateOfBirth,
    this.dateOfRegister,
  });
}

class Student with ChangeNotifier {
  StudentInf _inf = StudentInf(); // Initialize _inf with an empty StudentInf object

  StudentInf getStudentInf() {
    return _inf;
  }

  void setStudentInf(StudentInf inf) {
    _inf = inf;
    print(_inf);
    notifyListeners();
  }

  Future<bool> getInfWithID(String id) async {
    var response;
    var datauser;
    try {
      response = await http.post(
        Uri.parse("http://10.0.2.2/institutions/for_app/get_data/get_student_data.php"),
        body: {
          "id": id,
        },
      );
      if (response.statusCode == 200) {
        datauser = await json.decode(response.body);
        insertInf(datauser);
        return true;
      }
      print(datauser);
    } catch (e) {
      print(e);
    }
    return false;
  }

  insertInf(dynamic datauser) {
    StudentInf studentInf = StudentInf(
      id: datauser[0]['id'],
      schoolID: datauser[0]['school_id'],
      name: datauser[0]['name'],
      address: datauser[0]['address'],
      grade: datauser[0]['grade'],
      dateOfBirth: datauser[0]['date_of_birth'],
      dateOfRegister: datauser[0]['date_of_register'],
    );
    setStudentInf(studentInf);
  }

  logOut() {
    _inf = StudentInf();
    notifyListeners();
    print(_inf.id);
  }
}
