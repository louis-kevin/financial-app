import 'dart:ui' as ui;

import 'package:financialapp/config.dart';
import 'package:financialapp/routes/navigator.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:provider/provider.dart';

Locale deviceLocale = ui.window.locale;

var navigator = NavigatorSingleton();
var config = Config();

void main() => runApp(
      FutureBuilder(
        future: config.load(),
        builder: (_, data) {
          if (!data.hasData)
            return Container(
              color: DefaultColors.backgroundColor,
            );
          return I18n(
            initialLocale: Locale('en'),
            child: MyApp(),
          );
        },
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var authState = AuthState();

  @override
  void initState() {
    super.initState();
    authState.checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: authState,
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardState(),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountState(),
        ),
      ],
      child: MaterialApp(
        title: 'Financial',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator.key,
        theme: theme,
        supportedLocales: [
          const Locale('en'),
          const Locale('pt-br'),
        ],
        onGenerateRoute: Router.generateRoute,
        initialRoute: Router.SPLASH,
      ),
    );
  }
}
