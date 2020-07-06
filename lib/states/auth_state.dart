import 'package:dio/dio.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

class AuthState extends ChangeNotifier {
  bool logged;

  UserModel user;

  AuthService authService = AuthService();

  checkUser() async {
    Response response = await authService.me();

    this.user = UserModel.fromJson(response.data);

    this.logged = true;

    notifyListeners();

    Notifier()..fire(AuthStartedEvent(logged));
  }

  Future<void> login(Map data) {
    return _authenticate(() {
      return authService.login(data);
    });
  }

  Future<void> register(Map data) {
    return _authenticate(() {
      return authService.register(data);
    });
  }

  _authenticate(Function authenticationCall) async {
    Response response = await authenticationCall();

    var user = UserModel.fromJson(response.data);

    this.user = user;

    this.logged = true;

    notifyListeners();

    Notifier()..fire(Login(this.user));
  }
}
