import 'dart:convert';

import 'package:employee_app/data/employee.dart';
import 'package:employee_app/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../api_call/attendance.dart';

import '../components/home_page/employee_attendance_list_table.dart';

import '../components/navbar.dart';
import '../data/attendance_list.dart';
import '../utils/shared_pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AttendanceApi _attendanceApi = AttendanceApi();
  final SharedPrefForObject sharedPref = SharedPrefForObject();

  bool _isEmployeeAlreadyCome = false;
  bool _isloading = true;
  List<AttendanceList>? _attendanceList;
  Employee? _employee;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await getEmployeeData();
    if (_employee != null) {
      await validateEmployeeAttendanceToday();
      await loadData();
    }

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

  Future<void> validateEmployeeAttendanceToday() async {
    var response = await _attendanceApi.validateEmployeeAttendanceToday(
        employeeId: _employee?.id);

    if (response != null && response.success) {
      setState(() {
        _isEmployeeAlreadyCome = response.employeeAlreadyCome;
      });
    }
  }

  Future<void> loadData({DateTime? startAt, DateTime? endAt}) async {
    GetEmployeeAttendanceListRequest request = GetEmployeeAttendanceListRequest(
        _employee?.id ?? 1, getDateOnly(startAt), getDateOnly(endAt));

    var response = await _attendanceApi.getEmployeeAttendanceList(
        getEmployeeAttendanceListRequest: request);

    if (response != null && response.success) {
      setState(() {
        _attendanceList = response.attendanceListDTOS;
      });
    }
  }

  Widget headerTitle() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AutoSizeText(
        "Hai ${_employee?.name}",
        maxLines: 1,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      ),
      const Padding(padding: EdgeInsets.only(top: 10)),
      const AutoSizeText(
        "Selamat Datang di Aplikasi Absensi Karyawan",
        maxLines: 1,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      )
    ]);
  }

  void dateRangePickerDialog() async {
    final DateTimeRange? result = await showDateRangePicker(
        context: context,
        initialDateRange: _selectedDateRange,
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime.now(),
        cancelText: 'Kembali',
        confirmText: 'Filter',
        saveText: 'Filter',
        fieldStartLabelText: 'Tanggal Mulai',
        fieldEndLabelText: 'Tanggal Akhir',
        helpText: 'Masukkan Tanggal');

    if (result != null) {
      loadData(startAt: result.start, endAt: result.end);
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  Widget filterButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xff9f2a28)),
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
        dateRangePickerDialog();
      },
      child: const AutoSizeText(
        'Filter Tabel',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Future<void> addEmployeeAttendance(DateTime dateTime) async {
    final data = {
      'employeeId': _employee?.id,
      'workAttendance': !_isEmployeeAlreadyCome
    };

    var response = await _attendanceApi.addEmployeeAttendance(data: data);

    if (response != null && response.success) {
      await loadData();
      Navigator.pop(context);
    }
  }

  Widget attendanceButton() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff9f2a28)),
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
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => attendanceTrackDialog(),
            );
          },
          child: _isEmployeeAlreadyCome
              ? const AutoSizeText(
                  'Pulang Sekarang',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              : const AutoSizeText(
                  'Datang Sekarang',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
        ));
  }

  Widget attendanceTrackDialog() {
    DateTime currentDateTime = DateTime.now();
    String currentTime = showTimeOnly(currentDateTime);

    return AlertDialog(
      title: Text(
          _isEmployeeAlreadyCome == true ? "Absensi Pulang" : "Absensi Masuk"),
      content: Text(
          "Anda akan tercatat ${_isEmployeeAlreadyCome == true ? "pulang" : "masuk"} pada $currentTime"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
        TextButton(
          onPressed: () => addEmployeeAttendance(currentDateTime),
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: const AutoSizeText("Aplikasi Absensi Karyawan"),
      ),
      body: SingleChildScrollView(
        child: _isloading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    top: 30, right: 20, left: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    headerTitle(),
                    attendanceButton(),
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  "Daftar Absensi Anda:",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                                if (_selectedDateRange?.start != null &&
                                    _selectedDateRange?.end != null)
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: AutoSizeText(
                                      "Filter: ${showDateOnly(_selectedDateRange?.start)} - ${showDateOnly(_selectedDateRange?.end)}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                    ),
                                  )
                              ],
                            )),
                            Flexible(
                              child: filterButton(),
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 15)),
                        if (_attendanceList != null)
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: EmployeeAttendanceListTable(
                                  emplooyeeAttandanceList: _attendanceList)),
                      ]),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
