import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String appName = "Restaurant Top";
  static const String messageErrorConnection =
      "An Unknown network error has occured.";
  static const String searchDot = "Search...";
  static const String search = "Search";
  static const String searchRestaurant = "Search Restaurant";
  static const String pleaseFillFormSearch = "Please fill form search";
  static const String dataNotFound = "Data Not Found";
  static const String restaurant = "Restaurant";
  static const String favorite = "Favorite";
  static const String setting = "Setting";
  static const String foodsMenu = "Foods Menu";
  static const String drinksMenu = "Drinks Menu";
  static const String customerReviews = "Customer Reviews";
  static const String review = "Review";

  static String baseUrl = DotEnv().env['BASE_URL'];
  static String apiKey = DotEnv().env['API_KEY'];
  static String smallImage = DotEnv().env['SMALL_IMAGE'];
  static String mediumImage = DotEnv().env['MEDIUM_IMAGE'];
  static String largeImage = DotEnv().env['LARGE_IMAGE'];
}
