import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await DotEnv().load('.env');

  final api = ApiService();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => api),
      ],
      child: App(),
    ),
  );
}
