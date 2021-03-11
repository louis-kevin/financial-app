import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

enum Env { production, development, test, staging }

class Config {
  static Config _instance;

  factory Config() {
    _instance ??= Config._internalConstructor();
    return _instance;
  }

  Config._internalConstructor();

  bool loaded = false;

  Env _env;

  Env get env => _env;

  String _host;

  String get host => _host;

  Future<bool> load() async {
    await DotEnv.load(fileName: ".env");

    _env = Env.values.firstWhere(
      (name) => name.toString().replaceFirst('Env.', '') == DotEnv.env['ENV'],
    );

    _host = DotEnv.env['API_HOST'] ?? '';

    loaded = true;

    return true;
  }
}
