import 'package:dio/dio.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/services/auth_service.dart';
import 'package:financialapp/states/base_state.dart';

class AuthState extends BaseState {
  bool logged;

  UserModel user;

  AuthService authService = AuthService();

  AuthState() {
    Notifier()..listen((event) => logout());
  }

  checkUser() async {
    user = await _getUser();

    logged = user != null;

    notifyListeners();

    Notifier()..fire(AuthStartedEvent(logged, user));
  }

  Future<void> login(Map data) {
    return _authenticate(() async => await authService.login(data));
  }

  Future<void> register(Map data) {
    return _authenticate(() async => await authService.register(data));
  }

  Future<void> updateSettings(UserConfig userConfig) async {
    Response response = await authService.updateSettings(userConfig.toJson());

    var userConfigModel = UserConfig.fromJson(response.data);

    user?.config = userConfigModel;
  }

  Future<UserModel> _getUser() async {
    if (!await authService.hasToken) return null;

    try {
      Response response = await authService.me();
      return UserModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  _authenticate(Function authenticationCall) async {
    return handleAsync(() async {
      Response response = await authenticationCall();

      var user = UserModel.fromJson(response.data);

      print(user);

      this.user = user;

      this.logged = true;

      notifyListeners();

      Notifier()..fire(Login(this.user));
    });
  }

  void logout() {
    user = null;
    logged = false;

    notifyListeners();
  }
}
