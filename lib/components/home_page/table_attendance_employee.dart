
import 'package:flutter/material.dart';

import '../../data/attendance_list.dart';
import '../../utils/date.dart';

class TableAttendanceEmployee extends StatelessWidget {
  final List<AttendanceList>? emplooyeeAttandanceList;

  const TableAttendanceEmployee(
      {super.key, required this.emplooyeeAttandanceList});

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: Expanded(
              child: Center(
        child: Text("Tanggal"),
      ))),
      const DataColumn(
          label: Expanded(
              child: Center(
        child: Text("Masuk"),
      ))),
      const DataColumn(
          label: Expanded(
              child: Center(
        child: Text("Pulang"),
      ))),
    ];
  }

  List<DataRow> _createRows(List<AttendanceList>? data) {
    if (data == null) {
      return [];
    } else {
      return data
          .map((e) => DataRow(
                cells: [
                  DataCell(Center(child: Text((showDayAndDate(e.createdAt))))),
                  DataCell(Center(child: Text((showTimeOnly(e.startWorkAt))))),
                  DataCell(Center(child: Text((showTimeOnly(e.endWorkAt))))),
                ],
              ))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (emplooyeeAttandanceList == null) {
      return Container();
    } else {
      return DataTable(
        columns: _createColumns(),
        rows: _createRows(emplooyeeAttandanceList),
        showBottomBorder: true,
        dividerThickness: 2,
        border: TableBorder.symmetric(
            outside: BorderSide(color: Colors.black, width: 4),
            inside: BorderSide(color: Colors.black, width: 2)),
        headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Color.fromARGB(255, 214, 211, 211);
        }),
        headingTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      );
    }
  }
}
