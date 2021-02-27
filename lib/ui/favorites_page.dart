import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:dicoding_restaurant_app/provider/database_provider.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/data_not_found.dart';
import 'package:dicoding_restaurant_app/widgets/list_restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  Widget _buildWidget() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.HasData) {
          return ListRestaurant(
            restaurants: provider.favorite,
          );
        } else if (provider.state == ResultState.NoData) {
          print(provider.message);
          return DataNotFound(icon: Icons.restaurant);
        } else if (provider.state == ResultState.Error) {
          print(provider.message);
          return DataNotFound(icon: Icons.error_outline);
        } else {
          print(provider.message);
          return DataNotFound(icon: Icons.error_outline);
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.favorite),
      ),
      body: _buildWidget(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppConfig.favorite),
      ),
      child: _buildWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
