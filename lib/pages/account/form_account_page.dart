import 'package:easy_typography/easy_typography.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/dialogs/account_removal_dialog.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:financialapp/shared/inputs/name_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class FormAccountPage extends StatefulWidget {
  final AccountModel account;

  const FormAccountPage({Key key, this.account}) : super(key: key);

  @override
  _FormAccountPageState createState() => _FormAccountPageState();
}

class _FormAccountPageState extends State<FormAccountPage> {
  var formKey;
  MoneyMaskedTextController controller;

  Color currentColor;

  void save() async {
    if (!formKey.currentState.saveAndValidate()) return;

    Map<String, dynamic> data = Map.from(formKey.currentState.value);

    Map<String, dynamic> dataToAdd = {
      'color': currentColor.value,
      'amount_cents': data.remove('amount')
    };

    data.addAll(dataToAdd);

    var model = widget.account ?? AccountModel();

    model.fill(data);

    var state = context.read<AccountState>();

    await state.saveAccount(model);

    Notifier()..fire(AccountsUpdated());

    Navigator.of(context).pop(true);
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);

    Navigator.pop(context);
  }

  void showColorPicker() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: BodyMediumText.key(AccountPageTextKeys.titleSelectColor),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => changeColor(color),
          ),
        ),
      ),
    );
  }

  removeAccount() {
    Navigator.of(context).pop();

    var state = context.read<AccountState>();

    state.deleteAccount(widget.account);
  }

  deleteDialog() async {
    var result = await showDialog(
      context: context,
      builder: (_) => AccountRemovalDialog(account: widget.account),
    ) as bool;

    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    formKey = GlobalKey<FormBuilderState>();
    controller = MoneyMaskedTextController(
      decimalSeparator: MoneyTextKeys.decimalSeparator.i18n,
      thousandSeparator: MoneyTextKeys.thousandSeparator.i18n,
      leftSymbol: MoneyTextKeys.leftSymbol.i18n,
    );
    controller.updateValue(widget.account.amount);
    super.initState();
    currentColor = widget.account?.color ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      initialValue: {
        'name': widget.account?.name,
        'amount': widget.account?.amount
      },
      child: BaseBackButtonPage(
        titleKey: widget.account != null
            ? AccountPageTextKeys.editTitle
            : AccountPageTextKeys.addTitle,
        content: <Widget>[
          NameInput(context),
          SizedBox(height: 10),
          AmountInput(
            context,
            controller,
          ),
          buildColorSelector(),
        ],
        bottom: buildButtons(),
      ),
    );
  }

  Widget buildColorSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DisplaySmallText.key(AccountPageTextKeys.labelColor),
          GestureDetector(
            onTap: () => showColorPicker(),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButtons() {
    var saveButton = BaseButton(
      onPressed: save,
      textKey: AccountPageTextKeys.btnSave,
    );

    if (widget.account == null) return saveButton;

    return Column(
      children: <Widget>[
        saveButton,
        SizedBox(
          height: 20,
        ),
        BaseButton(
          onPressed: deleteDialog,
          type: ButtonType.danger,
          textKey: AccountPageTextKeys.btnDelete,
        ),
      ],
    );
  }
}
