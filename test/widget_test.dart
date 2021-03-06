import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/list_restaurant_result.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load();

  group('fetch restaurant', () {
    RestaurantProvider restaurantProvider;
    ApiService apiService;

    setUp(() {
      AppConfig.baseUrl = DotEnv().env['BASE_URL'];
      apiService = MockApiService();

      when(apiService.listRestaurants()).thenAnswer(
          (_) async => ListRestaurantResult.fromJson(restaurantResponse));

      restaurantProvider = RestaurantProvider(apiService: apiService);
    });

    test("get all restaurants", () async {
      var restaurants = restaurantProvider.result.restaurants[0];

      var result = restaurants.name == Restaurant.fromJsonList(restaurant).name;

      expect(result, true);
    });
  });
}

const restaurantResponse = {
  "error": false,
  "message": "success",
  "count": 20,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ],
};

const detailRestaurantResponse = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "rating": 4.2
  }
};

const restaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};
