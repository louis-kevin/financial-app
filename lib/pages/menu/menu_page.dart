import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  void goToAccountsPage(context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNTS);
  }

  void goToProfilePage(context) {
    Navigator.of(context).pushNamed(RouterManager.PROFILE);
  }

  void gotToSettingsPage(context) {
    Navigator.of(context).pushNamed(RouterManager.SETTINGS);
  }

  void goToWelcomePage(context) {
    Notifier()..fire(Logout());
  }

  @override
  Widget build(BuildContext context) {
    var authState = context.watch<AuthState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(),
                    ),
                    DisplaySmallText(authState.user?.name ?? ''),
                    LabelLargeText(authState.user?.email ?? '')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildMenuItem(
                      context,
                      MenuPageTextKeys.menuAccountsItem,
                      Icons.account_balance_wallet,
                      goToAccountsPage,
                    ),
                    buildMenuItem(
                      context,
                      MenuPageTextKeys.menuProfileItem,
                      Icons.person_outline,
                      goToProfilePage,
                    ),
                    buildMenuItem(
                      context,
                      MenuPageTextKeys.menuSettingsItem,
                      Icons.settings,
                      gotToSettingsPage,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LabelLargeText.key(MenuPageTextKeys.aboutUs),
                    SizedBox(
                      height: 10,
                    ),
                    LabelLargeText.key(MenuPageTextKeys.privacyPolicies),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => goToWelcomePage(context),
                      child: LabelLargeText.key(MenuPageTextKeys.logout),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  iconSize: 32,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
      context, String titleKey, IconData icon, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          HeadlineMediumText.key(
            titleKey,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
