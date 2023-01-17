import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Env { production, development, test, staging }

class Config {
  static final Config _instance = Config._internalConstructor();

  factory Config() {
    return _instance;
  }

  Config._internalConstructor();

  bool loaded = false;

  Env _env;

  Env get env => _env;

  String _host;

  String get host => _host;

  Future<bool> load() async {
    await dotenv.load(fileName: ".env");

    _env = Env.values.firstWhere(
      (name) => name.toString().replaceFirst('Env.', '') == dotenv.env['ENV'],
    );

    _host = dotenv.env['API_HOST'] ?? '';

    BaseTextLocale()..setLocale(Locale());

    loaded = true;

    return true;
  }
}
