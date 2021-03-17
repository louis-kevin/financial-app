import 'package:financialapp/models/user_model.dart';

class TokenExpired {}

class AppStartedEvent {}

class AuthStartedEvent {
  final bool logged;
  final UserModel user;

  AuthStartedEvent(this.logged, this.user);
}

class Logout {}

class Login {
  final UserModel user;

  Login(this.user);
}

class PushNotificationOpened {
  final String path;
  final String resourceId;

  PushNotificationOpened(this.path, this.resourceId);
}

class FcmTokenUpdated {
  final String fcmToken;

  FcmTokenUpdated(this.fcmToken);
}

class ContentNotFound {}

class TotalAmountUpdate {
  int oldAmount;
  int newAmount;

  TotalAmountUpdate({this.oldAmount, this.newAmount});
}

class AccountsUpdated {}
