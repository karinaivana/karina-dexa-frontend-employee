import 'dart:convert';

import 'package:employee_app/components/profile/edit_employee_data_form.dart';
import 'package:flutter/material.dart';

import '../data/employee.dart';
import '../utils/shared_pref.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final SharedPrefForObject sharedPref = SharedPrefForObject();

  bool _isloading = true;
  Employee? _employee;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await getEmployeeData();
  }

  Future<void> getEmployeeData() async {
    var data = await sharedPref.read("employee_data");

    if (data == null) {
      Navigator.of(context).pushNamed('/login');
    }

    if (data != null) {
      Employee currentEmployee = Employee.fromJson(jsonDecode(data));

      if (currentEmployee == null) {
        Navigator.of(context).pushNamed('/login');
      } else {
        setState(() {
          _isloading = false;
          _employee = currentEmployee;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Aplikasi Absensi Karyawan"),
        ),
        backgroundColor: Colors.white,
        body: _isloading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 10),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: const Text(
                      "Edit Profil",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                  ),
                  EditEmployeeDataForm(employee: _employee)
                ]),
              ));
  }
}
