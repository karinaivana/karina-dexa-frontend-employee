import 'package:dio/dio.dart';
import 'package:employee_app/data/add_attendance.dart';

import './link_constant.dart';
import '../data/attendance_list.dart';

class AttendanceApi {
  final Dio _dio = Dio();

  final _baseUrl = ATTENDANCE_LIST;

  Future<GetEmployeeAttendanceListResponse?> getEmployeeAttendanceList(
      {required GetEmployeeAttendanceListRequest
          getEmployeeAttendanceListRequest}) async {
    GetEmployeeAttendanceListResponse? result;
    try {
      var response = await _dio.get(
        _baseUrl + '/list',
        queryParameters: {
          'employeeId': getEmployeeAttendanceListRequest.employeeId,
          if (getEmployeeAttendanceListRequest.startAt != null)
            'startAt': getEmployeeAttendanceListRequest.startAt,
          if (getEmployeeAttendanceListRequest.endAt != null)
            'endAt': getEmployeeAttendanceListRequest.endAt
        },
      );

      if (response != null) {
        result = GetEmployeeAttendanceListResponse.fromJson(response.data);
      }
    } catch (e) {
      print('Error get employee list of attandance: $e');
    }
    return result;
  }

  Future<ValidateEmployeeAttendanceTodayResponse?>
      validateEmployeeAttendanceToday({int? employeeId}) async {
    ValidateEmployeeAttendanceTodayResponse? result;
    try {
      if (employeeId == null) return null;

      var response = await _dio.get(
        _baseUrl + '/validate/today',
        queryParameters: {
          'employeeId': employeeId,
        },
      );

      if (response != null) {
        result =
            ValidateEmployeeAttendanceTodayResponse.fromJson(response.data);
      }
    } catch (e) {
      print('Error valide employee attendance today: $e');
    }
    return result;
  }

  Future<AddEmployeeAttendanceResponse?> addEmployeeAttendance(
      {required Map<String, dynamic> data}) async {
    AddEmployeeAttendanceResponse? result;
    try {
      var response = await _dio.post(_baseUrl + '/add', data: data);

      if (response != null) {
        result = AddEmployeeAttendanceResponse.fromJson(response.data);
      }
    } catch (e) {
      print('Error valide employee attendance today: $e');
    }
    return result;
  }
}
