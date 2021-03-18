import 'package:dio/dio.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/services/account_service.dart';
import 'package:financialapp/services/bill_service.dart';
import 'package:financialapp/states/base_state.dart';

class AccountState extends BaseState {
  AccountService accountService = AccountService();

  BillService billService = BillService();

  List<AccountModel> accounts = [];

  AccountState() {
    Notifier()
      ..listen<AccountsUpdated>((AccountsUpdated event) {
        if (event.accounts.isNotEmpty) {
          this.accounts = event.accounts;
          notifyListeners();
          return null;
        }

        fetchAccounts();
      });

    Notifier()
      ..listen<AccountUpdated>((AccountUpdated event) {
        var account = event.account;
        var index = accounts.indexWhere((element) => element.id == account.id);
        accounts[index] = account;
        Notifier()..fire(AccountsUpdated(accounts: accounts));
      });
  }

  Future<List<AccountModel>> fetchAccounts() async {
    var async = () async {
      busy = true;

      Response response = await accountService.fetchAccounts();

      List data = response.data["data"];

      accounts =
          data.map((account) => AccountModel.fromJson((account))).toList();

      return accounts;
    };

    var runAlways = () {
      busy = false;
    };

    return handleAsync<List<AccountModel>>(async, runAlways: runAlways);
  }

  saveAccount(AccountModel model) async {
    var async = () async {
      bool modelExists = model.id != null;

      Response response =
          await accountService.saveAccount(model.toJson(), id: model.id);

      model.fill(response.data);

      if (!modelExists) accounts.add(model);
    };

    return handleAsync(async);
  }

  updateAccountsAmount(Map<dynamic, int> accountsData) {
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

  AccountModel findById(int id) {
    return accounts.firstWhere(
      (account) => account.id == id,
      orElse: () => null,
    );
  }

  void deleteAccount(AccountModel account) async {
    accounts.remove(account);
    notifyListeners();
    await accountService.removeAccount(account.id);
    Notifier()..fire(AccountsUpdated());
  }

  Future<List<BillModel>> fetchBillsFromAccount(AccountModel account) async {
    var async = () async {
      Response response = await billService.fetchBillsByAccount(account.id);

      var data = response.data as List<Map<String, dynamic>>;

      return data.map((bill) => BillModel.fromJson(bill)).toList();
    };

    return handleAsync(async);
  }
}
