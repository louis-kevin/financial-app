import 'package:dio/dio.dart';
import 'package:financialapp/services/base_service.dart';

class AuthService extends BaseService {
  Future<Response> me() {
    return get('user/me');
  }

  Future<Response> updateSettings(Map data) {
    return put('user/settings', data);
  }

  Future<Response> login(Map data) {
    return post('user/login', data);
  }

  Future<Response> register(Map data) {
    return post('user/register', data);
  }

  Future<Response> forgotPassword(Map data) {
    return post('user/reset-password', data);
  }
}
