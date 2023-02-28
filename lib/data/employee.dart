import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String email;
  final String password;
  @JsonKey(name: "roleDTO")
  final Role role;
  final String phoneNumber;
  final String? photoLink;

  Employee(this.id, this.createdAt, this.updatedAt, this.deletedAt, this.name,
      this.email, this.password, this.role, this.phoneNumber, this.photoLink);

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class Role {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String description;

  Role(this.id, this.createdAt, this.updatedAt, this.deletedAt,
      this.description);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final bool success;
  final String message;
  @JsonKey(name: "employeeDTO")
  final Employee employee;

  LoginResponse(this.success, this.message, this.employee);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class UpdateEmployeePersonalDataRequest {
  final int? employeeId;
  final String photoLink;
  final String phoneNumber;
  final String password;

  UpdateEmployeePersonalDataRequest(
      this.employeeId, this.photoLink, this.phoneNumber, this.password);

  factory UpdateEmployeePersonalDataRequest.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateEmployeePersonalDataRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateEmployeePersonalDataRequestToJson(this);
}

@JsonSerializable()
class UpdateEmployeePersonalDataResponse {
  final bool success;
  final String message;
  @JsonKey(name: "employeeDTO")
  final Employee employee;

  UpdateEmployeePersonalDataResponse(this.success, this.message, this.employee);

  factory UpdateEmployeePersonalDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateEmployeePersonalDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateEmployeePersonalDataResponseToJson(this);
}
