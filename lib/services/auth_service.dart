import 'package:dio/dio.dart';
import 'package:financialapp/services/base_service.dart';

var user = {'id': 1, 'name': 'Kevin', 'email': 'keviinlouis@hotmail.com'};

class AuthService extends BaseService {
  Future<Response> me() {
    return Future.delayed(
      Duration(milliseconds: 300),
      () => Response(data: user, statusCode: 200),
    );
    return get('me');
  }

  Future<Response> login(Map data) {
    return Future.delayed(
      Duration(milliseconds: 300),
      () => Response(data: user, statusCode: 200),
    );
    return post('login', data);
  }

  register(Map data) {
    return Future.delayed(
      Duration(milliseconds: 300),
      () => Response(data: user, statusCode: 200),
    );
    return post('register', data);
  }

  forgotPassword(Map data) {
    return Future.delayed(
      Duration(milliseconds: 300),
      () => Response(statusCode: 200),
    );
    return post('forgot-password', data);
  }
}
