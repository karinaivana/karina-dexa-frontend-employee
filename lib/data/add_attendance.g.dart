// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateEmployeeAttendanceTodayResponse
    _$ValidateEmployeeAttendanceTodayResponseFromJson(
            Map<String, dynamic> json) =>
        ValidateEmployeeAttendanceTodayResponse(
          json['success'] as bool,
          json['message'] as String,
          json['employeeAlreadyCome'] as bool,
        );

Map<String, dynamic> _$ValidateEmployeeAttendanceTodayResponseToJson(
        ValidateEmployeeAttendanceTodayResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'employeeAlreadyCome': instance.employeeAlreadyCome,
    };

AddEmployeeAttendanceResponse _$AddEmployeeAttendanceResponseFromJson(
        Map<String, dynamic> json) =>
    AddEmployeeAttendanceResponse(
      json['success'] as bool,
      json['message'] as String,
      json['workAttendance'] as bool,
    );

Map<String, dynamic> _$AddEmployeeAttendanceResponseToJson(
        AddEmployeeAttendanceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'workAttendance': instance.workAttendance,
    };
