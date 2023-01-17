import 'package:dio/dio.dart';
import 'package:financialapp/config.dart';
import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:get_storage/get_storage.dart';

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

    Notifier()..listen<Logout>(TokenManager.clearToken);
    Notifier()..listen<TokenExpired>(TokenManager.clearToken);
  }

  Future<bool> get hasToken async {
    return await TokenManager.fetchToken() != null;
  }

  Future<Response> get(String path, {Map query, Map headers}) {
    return _request('get', path, query: query, headers: headers);
  }

  Future<Response> post(String path, Map data, {Map query, Map headers}) {
    return _request('post', path, data: data, query: query, headers: headers);
  }

  Future<Response> put(String path, Map data, {Map query, Map headers}) {
    return _request('put', path, data: data, query: query, headers: headers);
  }

  Future<Response> delete(String path, {Map query, Map headers}) {
    return _request('delete', path, query: query, headers: headers);
  }

  Future<Response> save(String path, Map data,
      {String id, Map query, Map headers}) {
    String method = 'post';

    if (id != null) {
      path = "$path/$id";
      method = 'put';
    }

    return _request(method, path, data: data, query: query, headers: headers);
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
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(await _fetchAuthHeader());
    print("[DIO] REQUEST[${options?.method}] => PATH: ${options?.path}");
    print("[DIO] HEADERS: ${options.headers}");
    print("[DIO] BODY: ${options?.data}");
    print("[DIO] QUERY: ${options?.queryParameters}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "[DIO] RESPONSE[${response?.statusCode}] => PATH: ${response?.requestOptions?.path}");
    print("[DIO] BODY: ${response?.data}");

    _checkIfHasRenewHeader(response.headers);
    _checkIfHasTokenOnBody(response.data);

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    var response = error?.response;

    if (error.type != DioErrorType.response)
      return super.onError(error, handler);

    print(
        "ERROR[${response?.statusCode}] => PATH: ${error?.requestOptions?.uri?.path}");

    if (response?.statusCode == 401) {
      Notifier()..fire(Logout());
    }

    if (response?.statusCode == 422) {
      print("[DIO] MESSAGE => ${response.data}");
    }

    return super.onError(error, handler);
  }

  Future<Map<String, dynamic>> _fetchAuthHeader() async {
    String token = await TokenManager.fetchToken();

    if (token == null) return {};

    return {"authorization": "Bearer $token"};
  }

  void _checkIfHasRenewHeader(Headers headers) {
    var token = headers.value(BaseService.RENEW_TOKEN_KEY);
    if (token == null) return;
    TokenManager.writeToken(token);
  }

  void _checkIfHasTokenOnBody(data) {
    if (data == null || !(data is Map)) return;

    var token = data['token'];

    if (token == null) return;

    TokenManager.writeToken(token);
  }
}

class TokenManager {
  static void writeToken(token) {
    print('[JWT] Writing JWT TOKEN');
    final storage = new GetStorage();
    storage.write(BaseService.AUTH_TOKEN_KEY, token);
  }

  static void clearToken(_) {
    print('[JWT] Clearing JWT TOKEN');
    final storage = new GetStorage();
    storage.remove(BaseService.AUTH_TOKEN_KEY);
  }

  static Future<String> fetchToken() async {
    print('[JWT] Fetching JWT TOKEN');
    final storage = new GetStorage();
    return storage.read(BaseService.AUTH_TOKEN_KEY);
  }
}
