import 'package:json_annotation/json_annotation.dart';

part 'attendance_list.g.dart';

@JsonSerializable()
class AttendanceList {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int employeeId;
  final DateTime? startWorkAt;
  final DateTime? endWorkAt;

  AttendanceList(this.id, this.createdAt, this.updatedAt, this.deletedAt,
      this.employeeId, this.startWorkAt, this.endWorkAt);

  factory AttendanceList.fromJson(Map<String, dynamic> json) =>
      _$AttendanceListFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceListToJson(this);
}

@JsonSerializable()
class GetEmployeeAttendanceListResponse {
  final bool success;
  final String message;
  final List<AttendanceList> attendanceListDTOS;

  GetEmployeeAttendanceListResponse(
      this.success, this.message, this.attendanceListDTOS);

  factory GetEmployeeAttendanceListResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetEmployeeAttendanceListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetEmployeeAttendanceListResponseToJson(this);
}

@JsonSerializable()
class GetEmployeeAttendanceListRequest {
  final int employeeId;
  final String? startAt;
  final String? endAt;

  GetEmployeeAttendanceListRequest(this.employeeId, this.startAt, this.endAt);

  factory GetEmployeeAttendanceListRequest.fromJson(
          Map<String, dynamic> json) =>
      _$GetEmployeeAttendanceListRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetEmployeeAttendanceListRequestToJson(this);
}
