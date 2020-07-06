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
    print(1);

    notifier.listen<Logout>(handleLogout);

    notifier.listen<AuthStartedEvent>(handleAuthStarted);

    notifier.listen<PushNotificationOpened>(handlePushNotificationOpened);

    notifier.listen<ContentNotFound>(handleContentNotFound);
  }

  handleLogout(event) {
    this.key.currentState.pushNamed(Router.AUTH);
  }

  handleAuthStarted(AuthStartedEvent event) async {
    String route = Router.WELCOME;

    if (event.logged) {
      route = Router.HOME;
    }

    await Future.delayed(Duration(milliseconds: 300));

    if (!openedPushNotification || !event.logged) {
      this.key.currentState.pushNamed(route);
    }
  }

  handlePushNotificationOpened(PushNotificationOpened event) async {
    this.openedPushNotification = true;
    await this.key.currentState.pushNamed(
      event.path,
      arguments: {'id': event.resourceId},
    );
    this.openedPushNotification = false;

    handleAuthStarted(AuthStartedEvent(true));
  }

  handleContentNotFound(event) async {
    await this.key.currentState.pushReplacementNamed(Router.HOME);
  }
}
