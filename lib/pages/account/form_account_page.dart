import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/dialogs/account_removal_dialog.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:financialapp/shared/inputs/name_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/body2_text.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
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
  final formKey = GlobalKey<FormBuilderState>();

  Color currentColor;

  void save() async {
    if (!formKey.currentState.saveAndValidate()) return;

    Map data = formKey.currentState.value;

    data['color'] = currentColor.value;

    var model = widget.account ?? AccountModel();

    model.fill(data);

    var state = Provider.of<AccountState>(context, listen: false);

    await state.saveAccount(model);

    Navigator.of(context).pop();
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);

    Navigator.pop(context);
  }

  void showColorPicker() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Body2Text.key(AccountPageTextKeys.titleSelectColor),
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

    var state = Provider.of<AccountState>(context, listen: false);

    state.deleteAccount(widget.account);
  }

  deleteDialog() async {
    var result = await showDialog(
      context: context,
      child: AccountRemovalDialog(
        account: widget.account,
      ),
    ) as bool;

    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
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
          NameInput(),
          buildColorSelector(),
          AmountInput(
            value: widget.account?.amount,
          ),
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
          Display1Text.key(AccountPageTextKeys.labelColor),
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
