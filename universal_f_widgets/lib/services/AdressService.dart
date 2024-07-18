import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> _getPlaceDetails(String placeId) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyC5JwGGebkSRvbcbWsbg9bZjO7vNhI3loQ'));

    if (response.statusCode == 200) {
      final placeDetails = json.decode(response.body);
      for (var component in placeDetails['result']['address_components']) {
        if (component['types'].contains('postal_code')) {
          // _pincodeController.text = component['long_name'];
          break;
        }
      }
    } else {
      throw Exception('Failed to load place details');
    }
  }