import 'package:carousel_slider/carousel_slider.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/pages/settings/settings_second_step_page.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/display2_text.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController controller;
  int dayType = 0;
  bool _wantKeepAlive = false;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    controller = TextEditingController();

    controller.addListener(validateInput);

    super.initState();
  }

  void selectDayTypeOption(int value) {
    dayType = value;
    setState(() {});
    validateInput();
  }

  void validateInput() {
    int value = int.tryParse(controller.text);

    if (value == null) return;

    if (value < 1) {
      controller.clear();
    } else if (dayType == 0 && value > 20) {
      controller.clear();
    } else if (dayType == 1 && value > 31) {
      controller.clear();
    }

    setState(() {});
  }

  void nextPage() {
    int day = int.tryParse(controller.text);
    if (day == null) return;

    _wantKeepAlive = true;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsSecondStepPage(day: day, dayType: dayType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBackButtonPage(
      titleKey: SettingsPageTextKeys.firstTitle,
      content: <Widget>[
        SubtitleText.key(
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
      style: Theme.of(context).textTheme.display2,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        suffixText: 'ᵒ',
        suffixStyle: Theme.of(context).textTheme.display2,
        fillColor: DefaultColors.backgroundColor,
      ),
    );
  }

  Widget buildDayTypeSelector() {
    return CarouselSlider(
      items: [
        buildDayTypeOption(SettingsPageTextKeys.selectionWorkDay, 0),
        buildDayTypeOption(SettingsPageTextKeys.selectionAllDays, 1),
      ],
      options: CarouselOptions(
        viewportFraction: 0.2,
        height: 200,
        aspectRatio: 16 / 7,
        initialPage: 0,
        enableInfiniteScroll: false,
        onPageChanged: (value, _) => selectDayTypeOption(value),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget buildDayTypeOption(String titleKey, int value) {
    Color color = value == dayType ? Colors.white : DefaultColors.subtitleColor;
    return Display2Text.key(
      titleKey,
      textColor: color,
    );
  }
}
