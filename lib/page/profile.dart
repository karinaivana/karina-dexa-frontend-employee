import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee_app/components/navbar.dart';
import 'package:flutter/material.dart';

import '../data/employee.dart';
import '../utils/shared_pref.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    if (_employee != null) {}
    setState(() {
      _isloading = false;
    });
  }

  Future<void> getEmployeeData() async {
    var data = await sharedPref.read("employee_data");

    if (data == null) {
      Navigator.of(context).pushNamed('/login');
    } else {
      Employee currentEmployee = Employee.fromJson(jsonDecode(data));

      if (currentEmployee == null) {
        Navigator.of(context).pushNamed('/login');
      } else {
        setState(() {
          _employee = currentEmployee;
        });
      }
    }
  }

  Widget infoDetail(IconData icon, data) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: const Color(0xff9f2a28),
              size: 30.0,
            ),
            const Padding(padding: EdgeInsets.only(right: 10)),
            AutoSizeText(
              data,
              style: const TextStyle(fontSize: 20),
              maxLines: 1,
            )
          ],
        ));
  }

  Widget bodyDetail() {
    return Column(children: [
      AutoSizeText(
        "${_employee?.name}",
        maxLines: 1,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 10)),
      infoDetail(Icons.work, _employee!.role.description),
      infoDetail(Icons.email, _employee!.email),
      infoDetail(Icons.phone, _employee!.phoneNumber),
    ]);
  }

  Widget loadImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width * 0.2,
      child: Image.network(
        _employee?.photoLink ?? '',
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text('Error loading image.'),
          );
        },
      ),
    );
  }

  Widget editProfileButton() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff9f2a28)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
                  return const EdgeInsets.all(20);
                },
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile/edit');
            },
            child: const AutoSizeText(
              'Edit Profil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: const AutoSizeText("Aplikasi Absensi Karyawan"),
      ),
      body: SingleChildScrollView(
        child: _isloading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(
                    top: 30, right: 20, left: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [loadImage(), bodyDetail(), editProfileButton()],
                ),
              ),
      ),
    );
  }
}
