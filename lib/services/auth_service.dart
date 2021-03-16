import 'package:dio/dio.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/services/base_service.dart';

class AuthService extends BaseService {
  Future<UserModel> me() async {
    Response response = await get('user/me');

    return UserModel.fromJson(response.data);
  }

  Future<UserConfig> updateSettings(Map data) async {
    Response response = await put('user/settings', data);

    return UserConfig.fromJson(response.data);
  }

  Future<UserModel> login(Map data) async {
    Response response = await post('user/login', data);

    return UserModel.fromJson(response.data);
  }

  Future<UserModel> register(Map data) async {
    Response response = await post('user/register', data);

    return UserModel.fromJson(response.data);
  }

  Future<Response> forgotPassword(Map data) {
    return post('user/reset-password', data);
  }
}
