import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/pages/settings/settings_second_step_page.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller;
  UserConfig userConfig = UserConfig.empty();

  @override
  void initState() {
    controller = TextEditingController();

    controller.addListener(validateInput);

    super.initState();
  }

  void selectDayTypeOption(int value) {
    userConfig.dayType = value == 0 ? DayType.workDay : DayType.allDays;
    setState(() {});
    validateInput();
  }

  void validateInput() {
    int value = int.tryParse(controller.text);

    if (value == null) return;

    if (value < 1) {
      controller.clear();
    } else if (userConfig.dayType == DayType.workDay && value > 20) {
      controller.clear();
    } else if (userConfig.dayType == DayType.allDays && value > 31) {
      controller.clear();
    } else {
      userConfig.day = value;
    }

    setState(() {});
  }

  void nextPage() {
    int day = int.tryParse(controller.text);
    if (day == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsSecondStepPage(userConfig: userConfig),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var authState = context.watch<AuthState>();

    if (authState.user?.config != null) {
      userConfig = authState.user.config;
      controller.text = userConfig.day.toString();
    }

    return BaseBackButtonPage(
      titleKey: SettingsPageTextKeys.firstTitle,
      content: <Widget>[
        BodyMediumText.key(
          SettingsPageTextKeys.firstSubtitle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: buildDayField(),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: buildDayTypeSelector(),
            ),
          ],
        ),
      ],
      bottom: BaseButton(
        textKey: SettingsPageTextKeys.btnNext,
        onPressed: nextPage,
      ),
    );
  }

  Widget buildDayField() {
    return TextField(
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.end,
      style: Theme.of(context).textTheme.displaySmall,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        suffixText: '°',
        suffixStyle: Theme.of(context).textTheme.displaySmall,
        fillColor: DefaultColors.backgroundColor,
      ),
    );
  }

  Widget buildDayTypeSelector() {
    int initialPage = userConfig?.dayType == DayType.allDays ? 1 : 0;

    return CarouselSlider(
      items: [
        buildDayTypeOption(
            SettingsPageTextKeys.selectionWorkDay, DayType.workDay),
        buildDayTypeOption(
            SettingsPageTextKeys.selectionAllDays, DayType.allDays),
      ],
      options: CarouselOptions(
        viewportFraction: 0.2,
        height: 200,
        aspectRatio: 16 / 7,
        initialPage: initialPage,
        enableInfiniteScroll: false,
        onPageChanged: (value, _) => selectDayTypeOption(value),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget buildDayTypeOption(String titleKey, DayType value) {
    Color color = value == userConfig.dayType
        ? Colors.white
        : DefaultColors.subtitleColor;
    return DisplaySmallText.key(
      titleKey,
      textColor: color,
    );
  }
}
