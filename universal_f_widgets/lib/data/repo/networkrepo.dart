import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_f_widgets/models/BaseResponse.dart';

class NetorkinRepository {
  final String baseUrl;

  NetorkinRepository(this.baseUrl);

  Future<BaseResponse<T>> get<T>({
    required String path,
    required T Function(dynamic) dataMapper,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
      final headers = token != null ? {'x-access-token': '$token'} : null;

      final response = await http.get(uri, headers: headers);

      return _handleResponse(response, dataMapper);
    } catch (e) {
      return BaseResponse.error(e.toString());
    }
  }

  Future<BaseResponse<T>> post<T>({
    required String path,
    required T Function(dynamic) dataMapper,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'x-access-token': ' $token',
      };

      final response = await http.post(uri, headers: headers, body: jsonEncode(data));

      return _handleResponse(response, dataMapper);
    } catch (e) {
      return BaseResponse.error(e.toString());
    }
  }

  BaseResponse<T> _handleResponse<T>(http.Response response, T Function(dynamic) dataMapper) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return BaseResponse.fromJson(json, dataMapper: dataMapper);
    } else {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return BaseResponse.error(json['message'] ?? 'Unknown error');
    }
  }
}
