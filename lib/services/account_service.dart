import 'package:dio/dio.dart';
import 'package:financialapp/services/base_service.dart';

class AccountService extends BaseService {
  Future<Response> fetchAccounts() {
    return get('accounts');
  }

  Future<Response> saveAccount(Map<String, dynamic> data, {int id}) {
    String url = '/account';

    return save(url, data, id: id?.toString());
  }

  Future<Response> removeAccount(id) {
    String url = "/account/$id";

    return delete(url);
  }

  Future<Response> updateAmounts(List<Map<String, dynamic>> data) {
    String url = '/accounts';

    return put(url, {'accounts': data});
  }
}
