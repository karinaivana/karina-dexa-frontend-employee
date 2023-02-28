// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      json['id'] as int,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['name'] as String,
      json['email'] as String,
      json['password'] as String,
      json['role'] as String,
      json['phoneNumber'] as String,
      json['photoLink'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'phoneNumber': instance.phoneNumber,
      'photoLink': instance.photoLink,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['success'] as bool,
      json['message'] as String,
      Employee.fromJson(json['employeeDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'employeeDTO': instance.employee,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

UpdateEmployeePersonalDataRequest _$UpdateEmployeePersonalDataRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateEmployeePersonalDataRequest(
      json['employeeId'] as int?,
      json['photoLink'] as String,
      json['phoneNumber'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$UpdateEmployeePersonalDataRequestToJson(
        UpdateEmployeePersonalDataRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'photoLink': instance.photoLink,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
    };

UpdateEmployeePersonalDataResponse _$UpdateEmployeePersonalDataResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateEmployeePersonalDataResponse(
      json['success'] as bool,
      json['message'] as String,
      Employee.fromJson(json['employeeDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateEmployeePersonalDataResponseToJson(
        UpdateEmployeePersonalDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'employeeDTO': instance.employee,
    };
