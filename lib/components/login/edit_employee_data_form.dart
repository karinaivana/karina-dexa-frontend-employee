import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee_app/data/employee.dart';
import 'package:flutter/material.dart';

import '../../api_call/employee.dart';
import '../../constant/route_name.dart';
import '../../utils/shared_pref.dart';

class EditEmployeeDataForm extends StatefulWidget {
  Employee? employee;

  EditEmployeeDataForm({super.key, required this.employee});

  @override
  State<EditEmployeeDataForm> createState() => _EditEmployeeDataFormState();
}

class _EditEmployeeDataFormState extends State<EditEmployeeDataForm> {
  late TextEditingController photoLinkController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();
  final EmployeeApi employeeApi = EmployeeApi();
  final SharedPrefForObject sharedPref = SharedPrefForObject();
  bool _showPassword = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    photoLinkController =
        TextEditingController(text: widget.employee?.photoLink);
    phoneNumberController =
        TextEditingController(text: widget.employee?.phoneNumber);
    passwordController = TextEditingController(text: widget.employee?.password);
  }

  @override
  void dispose() {
    photoLinkController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> updateEmployeeData() async {
    if (widget.employee?.id == null) return;

    UpdateEmployeePersonalDataRequest request =
        UpdateEmployeePersonalDataRequest(
            widget.employee?.id,
            photoLinkController.text,
            phoneNumberController.text,
            passwordController.text);

    var response = await employeeApi.updateEmployeeData(
        updateEmployeePersonalDataRequest: request);

    if (response != null && response.employee != null) {
      await sharedPref.save('employee_data', jsonEncode(response.employee));

      Navigator.of(context).pushNamed(RoutesName.PROFILE);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => editFailedDialog(),
      );
    }
  }

  void changeShowPasswordValue() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget editFailedDialog() {
    return AlertDialog(
      title: const AutoSizeText('Edit Data Gagal'),
      content: const AutoSizeText('Mohon periksa kembali data yang diisi'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const AutoSizeText('Kembali'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const AutoSizeText('OK'),
        ),
      ],
    );
  }

  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff9f2a28)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            updateEmployeeData();
          }
        },
        child: const AutoSizeText(
          'EDIT PROFIL',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.photo),
                  hintText: 'Link Photo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: photoLinkController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Nomor Handphone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nomor handphone anda';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 5),
              child: TextFormField(
                obscureText: !_showPassword,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    hintText: 'Kata Sandi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    )),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kata sandi anda';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(children: [
                Checkbox(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }),
                AutoSizeText("Lihat Kata Sandi", maxLines: 1)
              ]),
            ),
            loginButton()
          ],
        ));
  }
}
