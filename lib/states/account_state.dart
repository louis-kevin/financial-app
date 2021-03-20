import 'package:dio/dio.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/services/account_service.dart';
import 'package:financialapp/states/base_state.dart';

class AccountState extends BaseState {
  AccountService accountService = AccountService();

  List<AccountModel> _accounts = [];

  List<AccountModel> get accounts => _accounts;

  set accounts(List<AccountModel> accounts) {
    List<AccountModel> newData = accounts.map((AccountModel element) {
      var index =
          this._accounts.indexWhere((account) => element.id == account.id);
      if (index <= -1) return element;
      element.billState = this.accounts[index].billState;
      return element;
    }).toList();

    this._accounts = newData;
  }

  AccountState() {
    Notifier()
      ..listen<AccountsUpdated>((AccountsUpdated event) {
        if (event.hasAccounts) {
          this.accounts = event.accounts;
          notifyListeners();
          return null;
        }

        fetchAccounts();
      });

    Notifier()
      ..listen<AccountSaved>((AccountSaved event) {
        var account = event.account;
        var index = accounts.indexWhere((element) => element.id == account.id);
        if (index > -1) {
          accounts[index].fill(account.toJson());
        } else {
          accounts.add(account);
        }
        Notifier()..fire(AccountsUpdated(accounts: accounts));
      });
  }

  Future<List<AccountModel>> fetchAccounts() async {
    var async = () async {
      busy = true;

      Response response = await accountService.fetchAccounts();

      List data = response.data["data"];

      List<AccountModel> accounts =
          data.map((account) => AccountModel.fromJson((account))).toList();

      this.accounts = accounts;

      return accounts;
    };

    var runAlways = () {
      busy = false;
    };

    return handleAsync<List<AccountModel>>(async, runAlways: runAlways);
  }

  Future<void> saveAccount(AccountModel model) async {
    var async = () async {
      Response response =
          await accountService.saveAccount(model.toJson(), id: model.id);

      model.fill(response.data);

      Notifier()..fire(AccountSaved(model));
    };

    handleAsync(async);
  }

  Future<void> updateAccountsAmount(Map<dynamic, int> accountsData) {
    List<Map<String, dynamic>> accountsUpdated = [];

    accountsData.forEach((id, amountCents) {
      accountsUpdated.add({'id': int.parse(id), 'amount_cents': amountCents});
    });

    var async = () async {
      Response response = await accountService.updateAmounts(accountsUpdated);

      var data = response.data as List;

      var accounts =
          data.map((account) => AccountModel.fromJson(account)).toList();

      Notifier()..fire(AccountsUpdated(accounts: accounts));
    };

    return handleAsync(async);
  }

  Future<void> deleteAccount(AccountModel account) async {
    accounts.remove(account);
    notifyListeners();
    await accountService.removeAccount(account.id);
    Notifier()..fire(AccountsUpdated());
  }

  AccountModel findById(int id) {
    return accounts.firstWhere(
      (account) => account.id == id,
      orElse: () => null,
    );
  }
}
