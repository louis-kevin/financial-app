import 'package:financialapp/pages/account/form_account_page.dart';
import 'package:financialapp/pages/accountMoneyUpdate/account_money_update_page.dart';
import 'package:financialapp/pages/accounts/accounts_page.dart';
import 'package:financialapp/pages/auth/auth_page.dart';
import 'package:financialapp/pages/auth/welcome_page.dart';
import 'package:financialapp/pages/bill/form_bill_page.dart';
import 'package:financialapp/pages/home/home_page.dart';
import 'package:financialapp/pages/menu/menu_page.dart';
import 'package:financialapp/pages/profile/profile_page.dart';
import 'package:financialapp/pages/settings/settings_page.dart';
import 'package:financialapp/pages/splash/spalsh_page.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Routes {
  account,
  accounts,
  bill,
  welcome,
  auth,
  home,
  menu,
  profile,
  accountMoneyUpdate,
  settings,
}

class RouterManager {
  static const ACCOUNT = 'account';
  static const ACCOUNTS = 'accounts';
  static const BILL = 'bill';
  static const WELCOME = 'welcome';
  static const SPLASH = 'splash';
  static const AUTH = 'auth';
  static const HOME = 'home';
  static const MENU = 'menu';
  static const PROFILE = 'profile';
  static const ACCOUNT_MONEY_UPDATE = 'accountMoneyUpdate';
  static const SETTINGS = 'settings';

  static Map<String, Function> routes = {
    SPLASH: (arguments) => SplashPage(),
    WELCOME: (arguments) => WelcomePage(),
    AUTH: (arguments) => AuthPage(),
    HOME: (arguments) => HomePage(),
    ACCOUNT: (RouteArguments arguments) => FormAccountPage(
          account: arguments.model,
        ),
    BILL: (RouteArguments arguments) => FormBillPage(
          model: arguments.model,
        ),
    MENU: (arguments) => MenuPage(),
    ACCOUNTS: (arguments) => AccountsPage(),
    PROFILE: (arguments) => ProfilePage(),
    SETTINGS: (RouteArguments arguments) => SettingsPage(),
    ACCOUNT_MONEY_UPDATE: (arguments) => AccountMoneyUpdatePage(),
  };

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    RouteArguments arguments = routeSettings.arguments ?? RouteArguments();
    Widget page = findRoute(routeSettings.name, arguments);

    return findTransition(page, arguments);
  }

  static Route findTransition(Widget page, RouteArguments arguments) {
    if (arguments.transitionBuilder != null) {
      return arguments.transitionBuilder(page);
    }

    var transition = arguments.transitions;

    if (transition == RouterTransitions.normal) {
      return MaterialPageRoute(builder: (_) => page);
    }

    if (transition == RouterTransitions.fade) {
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    }

    throw 'Transition route not founded';
  }

  static findRoute(String name, RouteArguments arguments) {
    if (!routes.containsKey(name)) throw 'Route not founded';

    return routes[name](arguments);
  }
}
