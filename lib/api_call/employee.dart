import 'package:dio/dio.dart';

import './link_constant.dart';
import '../data/employee.dart';

class EmployeeApi {
  final Dio _dio = Dio();

  final _baseUrl = '$EMPLOYEE';

  Future<LoginResponse?> loginToAppTest(
      {required LoginRequest loginRequest}) async {
    LoginResponse? result;
    try {
      Response response = await _dio.post(
        _baseUrl + '/login',
        data: loginRequest.toJson(),
      );
      result = LoginResponse.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }
    return result;
  }

  Future<UpdateEmployeePersonalDataResponse?> updateEmployeeData(
      {required UpdateEmployeePersonalDataRequest
          updateEmployeePersonalDataRequest}) async {
    UpdateEmployeePersonalDataResponse? result;
    try {
      Response response = await _dio.post(
        _baseUrl + '/update',
        data: updateEmployeePersonalDataRequest.toJson(),
      );
      result = UpdateEmployeePersonalDataResponse.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }
    return result;
  }
}
