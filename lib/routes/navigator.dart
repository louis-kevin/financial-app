import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:flutter/material.dart';

class NavigatorSingleton {
  static NavigatorSingleton _instance;

  factory NavigatorSingleton() {
    _instance ??= NavigatorSingleton._internalConstructor();
    return _instance;
  }

  GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  bool openedPushNotification = false;

  NavigatorSingleton._internalConstructor() {
    Notifier notifier = Notifier();

    notifier.listen<Logout>(handleLogout);

    notifier.listen<AuthStartedEvent>(handleAuthStarted);

    notifier.listen<PushNotificationOpened>(handlePushNotificationOpened);

    notifier.listen<ContentNotFound>(handleContentNotFound);
  }

  handleLogout(event) {
    pushReplacementNamed(RouterManager.WELCOME);
  }

  handleAuthStarted(AuthStartedEvent event) async {
    if (!event.logged) return pushReplacementNamed(RouterManager.WELCOME);

    if (event.user.needsConfig)
      return pushReplacementNamed(RouterManager.SETTINGS);

    pushReplacementNamed(RouterManager.HOME);
  }

  handlePushNotificationOpened(PushNotificationOpened event) async {
    this.openedPushNotification = true;
    await pushReplacementNamed(
      event.path,
      arguments: {'id': event.resourceId},
    );
    this.openedPushNotification = false;
  }

  handleContentNotFound(event) async {
    await this.key.currentState?.pushReplacementNamed(RouterManager.HOME);
  }

  pushReplacementNamed(String name, {arguments}) {
    return this.key.currentState?.pushNamedAndRemoveUntil(
          name,
          (Route<dynamic> route) => false,
          arguments: arguments,
        );
  }
}
