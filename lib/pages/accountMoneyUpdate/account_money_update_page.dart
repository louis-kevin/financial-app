import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/pages/accountMoneyUpdate/account_amount_field.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class AccountMoneyUpdatePage extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  save(context, AccountState accountState) async {
    if (!formKey.currentState.saveAndValidate()) return;

    Map<dynamic, int> data = Map.from(formKey.currentState.value);

    await accountState.updateAccountsAmount(data);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AccountState>();

    return FormBuilder(
      key: formKey,
      child: BaseBackButtonPage(
        titleKey: AccountMoneyUpdatePageTextKeys.title,
        content: buildAccounts(state.accounts),
        bottom: BaseButton(
          textKey: AccountMoneyUpdatePageTextKeys.btnSave,
          onPressed: () => save(context, state),
        ),
      ),
    );
  }

  List<Widget> buildAccounts(List<AccountModel> accounts) {
    return accounts.map(buildAccount).toList();
  }

  Widget buildAccount(AccountModel account) {
    return AccountAmountField(account: account);
  }
}
