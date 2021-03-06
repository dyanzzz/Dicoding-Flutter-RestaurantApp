import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:flutter/material.dart';

import '../common/styles.dart';

class DataNotFound extends StatelessWidget {
  final IconData icon;
  DataNotFound({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 150,
          ),
          Text(
            AppConfig.dataNotFound,
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
