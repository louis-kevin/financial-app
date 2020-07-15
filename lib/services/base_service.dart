import 'package:dio/dio.dart';
import 'package:financialapp/config.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;

class BaseService {
  static const AUTH_TOKEN_KEY = 'JWT_TOKEN';
  static const RENEW_TOKEN_KEY = 'renew-auth';

  String host;
  Dio client;

  BaseService() {
    var config = Config();

    host = config.host;

    BaseOptions options = BaseOptions(baseUrl: host);

    client = new Dio(options);

    client.interceptors.add(AuthenticationInterceptor());

    Notifier()..listen<Logout>((logout) => clearToken());
  }

  Future<String> get token async {
    final storage = new Storage.FlutterSecureStorage();

    return await storage.read(key: BaseService.AUTH_TOKEN_KEY);
  }

  Future<bool> get hasToken async {
    String token = await this.token;

    return token != null;
  }

  void clearToken() {
    final storage = new Storage.FlutterSecureStorage();

    storage.delete(key: BaseService.AUTH_TOKEN_KEY);
  }

  get(String path, {Map query, Map headers}) {
    return _request('get', path, query: query, headers: headers);
  }

  post(String path, Map data, {Map query, Map headers}) {
    return _request('post', path, data: data, query: query, headers: headers);
  }

  put(String path, Map data, {Map query, Map headers}) {
    return _request('put', path, data: data, query: query, headers: headers);
  }

  delete(String path, {Map query, Map headers}) {
    return _request('delete', path, query: query, headers: headers);
  }

  Future<Response> _request(String method, String path,
      {Map data, Map query, Map headers}) {
    String url = _buildUrl(path);
    Map baseHeaders = _buildHeaders(headers: headers);

    return client.request(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: baseHeaders,
        method: method,
      ),
    );
  }

  String _buildUrl(String path) {
    if (!path.startsWith('/')) {
      path = "/$path";
    }
    var uri = Uri(path: path);
    return uri.toString();
  }

  Map _buildHeaders({Map headers}) {
    Map baseHeaders = {};

    if (headers != null) baseHeaders.addAll(headers);

    return headers;
  }
}

class AuthenticationInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    options.headers.addAll(await _fetchAuthHeader());
    print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    print("HEADERS: ${options.headers}");
    print("BODY: ${options?.data}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    print("BODY: ${response?.data}");

    _checkIfHasRenewHeader(response.headers);
    _checkIfHasTokenOnBody(response.data);

    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) async {
    var response = error?.response;
    print(
        "ERROR[${response?.statusCode}] => PATH: ${error?.request?.uri?.path}");

    if (error.type != DioErrorType.RESPONSE) return super.onError(error);

    if (response.statusCode == 401) {
      Notifier()..fire(Logout());
    }

    if (response.statusCode == 422) {
      print("MESSAGE => ${response.data}");
    }

    return super.onError(error);
  }

  Future<Map<String, dynamic>> _fetchAuthHeader() async {
    String token = await _fetchJwtToken();

    if (token == null) return {};

    return {"authorization": "Bearer $token"};
  }

  void _checkIfHasRenewHeader(Headers headers) {
    var token = headers.value(BaseService.RENEW_TOKEN_KEY);
    if (token == null) return;
    _writeJwtToken(token);
  }

  void _checkIfHasTokenOnBody(data) {
    if (data == null) return;

    var token = data['token'];

    if (token == null) return;

    _writeJwtToken(token);
  }

  void _writeJwtToken(token) {
    print('Writing JWT TOKEN');
    final storage = new Storage.FlutterSecureStorage();
    storage.write(key: BaseService.AUTH_TOKEN_KEY, value: token);
  }

  Future<String> _fetchJwtToken() async {
    final storage = new Storage.FlutterSecureStorage();

    return storage.read(key: BaseService.AUTH_TOKEN_KEY);
  }
}
