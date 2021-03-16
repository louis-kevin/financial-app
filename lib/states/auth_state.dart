import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/services/auth_service.dart';
import 'package:financialapp/states/base_state.dart';

typedef AuthenticationCall = Future<UserModel> Function();

class AuthState extends BaseState {
  bool logged;

  UserModel user;

  AuthService authService = AuthService();

  AuthState() {
    Notifier()..listen<Logout>((event) => logout());
  }

  Future<void> checkUser() async {
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
    var userConfigModel = await authService.updateSettings(userConfig.toJson());

    user?.config = userConfigModel;
  }

  Future<UserModel> _getUser() async {
    if (!await authService.hasToken) return null;

    try {
      return await authService.me();
    } catch (e) {
      Notifier()..fire(TokenExpired());
      return null;
    }
  }

  _authenticate(AuthenticationCall authenticationCall) async {
    return handleAsync(() async {
      UserModel user = await authenticationCall();

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
