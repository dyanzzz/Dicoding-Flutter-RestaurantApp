import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String AppName = "Restaurant Top";
  static const String MessageErrorConnection =
      "An Unknown network error has occured.";
  static const String SearchDot = "Search...";
  static const String Search = "Search";
  static const String PleaseFillFormSearch = "Please fill form search";

  static String baseUrl = DotEnv().env['BASE_URL'];
  static String apiKey = DotEnv().env['API_KEY'];
  static String smallImage = DotEnv().env['SMALL_IMAGE'];
  static String mediumImage = DotEnv().env['MEDIUM_IMAGE'];
  static String largeImage = DotEnv().env['LARGE_IMAGE'];
}
