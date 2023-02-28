import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../api_call/employee.dart';
import '../data/employee.dart';

import '../utils/shared_pref.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      return setState(() {
        _isloading = false;
      });
    }

    if (data != null) {
      Employee currentEmployee = Employee.fromJson(jsonDecode(data));

      if (currentEmployee != null) {
        Navigator.of(context).pushNamed('/homepage');
      } else {
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Aplikasi Absensi Karyawan"),
        ),
        backgroundColor: Colors.white,
        body: _isloading
            ? const Center(child: CircularProgressIndicator())
            : const LoginPageBody());
  }
}

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: const Text(
            "Masuk",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
        ),
        const LoginForm()
      ]),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final EmployeeApi employeeApi = EmployeeApi();
  final SharedPrefForObject sharedPref = SharedPrefForObject();
  bool _showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginToServer() async {
    LoginRequest request =
        LoginRequest(emailController.text, passwordController.text);

    var response = await employeeApi.login(loginRequest: request);

    if (response != null && response.employee != null) {
      sharedPref.save('employee_data', jsonEncode(response.employee));

      Navigator.of(context).pushNamed('/homepage');
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => loginFailedDialog(),
      );
    }
  }

  void changeShowPasswordValue() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget loginFailedDialog() {
    return AlertDialog(
      title: const Text('Login Gagal'),
      content: const Text('Mohon periksa kembali email atau password anda'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
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
            loginToServer();
          }
        },
        child: const Text(
          'MASUK',
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
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email Perusahaan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan email perusahaan anda';
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
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(children: [
                Checkbox(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }),
                const AutoSizeText("Lihat Kata Sandi", maxLines: 1)
              ]),
            ),
            loginButton()
          ],
        ));
  }
}
