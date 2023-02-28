import 'package:json_annotation/json_annotation.dart';

part 'add_attendance.g.dart';

@JsonSerializable()
class ValidateEmployeeAttendanceTodayResponse {
  final bool success;
  final String message;
  final bool employeeAlreadyCome;

  ValidateEmployeeAttendanceTodayResponse(
      this.success, this.message, this.employeeAlreadyCome);

  factory ValidateEmployeeAttendanceTodayResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ValidateEmployeeAttendanceTodayResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ValidateEmployeeAttendanceTodayResponseToJson(this);
}

@JsonSerializable()
class AddEmployeeAttendanceResponse {
  final bool success;
  final String message;
  final bool workAttendance;

  AddEmployeeAttendanceResponse(
      this.success, this.message, this.workAttendance);

  factory AddEmployeeAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$AddEmployeeAttendanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddEmployeeAttendanceResponseToJson(this);
}
