import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:flutter/material.dart';

import '../common/styles.dart';

class ErrorConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            color: primaryColor,
            size: 100,
          ),
          Text(
            AppConfig.MessageErrorConnection,
            style: TextStyle(
                color: primaryColor, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
