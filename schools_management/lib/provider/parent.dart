import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ParentInf {
  final String? id;
  final String? schoolID;
  final String? studentID;
  final String? name;
  final String? email;
  final String? address;
  final String? number;
  final String? dateOfRegister;

  ParentInf({
    this.id,
    this.schoolID,
    this.studentID,
    this.name,
    this.email,
    this.address,
    this.number,
    this.dateOfRegister,
  });
}

class Parent with ChangeNotifier {
  ParentInf _inf = ParentInf(); // Initialize _inf with an empty ParentInf object

  ParentInf getParentInf() {
    return _inf;
  }

  void setParentInf(ParentInf inf) {
    _inf = inf;
    print(_inf);
    notifyListeners();
  }

  Future<bool> loginParentAndGetInf(String user, String pass) async {
    var response;
    var datauser;
    try {
      response = await http.post(
        Uri.parse("http://10.0.2.2/institutions/for_app/login_parents.php"),
        body: {
          "username": user.trim(),
          "password": pass.trim(),
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
    ParentInf parentInf = ParentInf(
      id: datauser[0]['id'],
      studentID: datauser[0]['student_id'],
      schoolID: datauser[0]['school_id'],
      name: datauser[0]['name'],
      address: datauser[0]['address'],
      number: datauser[0]['number'],
      email: datauser[0]['email'],
      dateOfRegister: datauser[0]['date_of_register'],
    );
    setParentInf(parentInf);
  }

  logOut() {
    _inf = ParentInf();
    notifyListeners();
    print(_inf.id);
  }
}
