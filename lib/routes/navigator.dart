import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/routes/router.dart';
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
    pushReplacementNamed(Router.WELCOME);
  }

  handleAuthStarted(AuthStartedEvent event) async {
    if (!event.logged) return pushReplacementNamed(Router.WELCOME);

    if (event.user.needsConfig) return pushReplacementNamed(Router.SETTINGS);

    pushReplacementNamed(Router.HOME);
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
    await this.key.currentState.pushReplacementNamed(Router.HOME);
  }

  _pushNamed(String name, {arguments}) {
    return this.key.currentState.pushNamed(name, arguments: arguments);
  }

  pushReplacementNamed(String name, {arguments}) {
    return this.key.currentState.pushNamedAndRemoveUntil(
          name,
          (Route<dynamic> route) => false,
          arguments: arguments,
        );
  }
}
