import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_urls.dart';

class ApiService {
  final Dio _dio;

  final String baseUrl = AppUrl.baseUrl;

  ApiService(this._dio);

  get({required String endPoint, Map<String, dynamic>? params}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    final fullUrl = '$baseUrl/$endPoint';
    print('\n🔹 [GET] Request to: $fullUrl');
    print('🔸 Query Parameters: $params');
    print('🔸 Authorization Token: $token');

    final response = await _dio.get(
      fullUrl,
      queryParameters: params,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    print('✅ [GET] Response: ${response.data}');
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? params,
  }) async {
    final fullUrl = '$baseUrl/$endPoint';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    print('\n🔹 [POST] Request to: $fullUrl');
    print('🔸 Query Parameters: $params');
    print('🔸 Body: $body');
    print('🔸 Authorization Token: $token');

    final response = await _dio.post(
      fullUrl,
      queryParameters: params,
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print('✅ [POST] Response: ${response.data}');
    return response.data;
  }

  postFormData({required String endPoint, required body}) async {
    final fullUrl = '$baseUrl/$endPoint';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    print('\n🔹 [POST FORM] Request to: $fullUrl');
    print('🔸 Body (FormData): $body');
    print('🔸 Authorization Token: $token');

    final response = await _dio.post(
      fullUrl,
      data: FormData.fromMap(body),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    print('✅ [POST FORM] Response: ${response.data}');
    return response.data;
  }

  putFormData({required String endPoint, required body}) async {
    final fullUrl = '$baseUrl/$endPoint';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    print('\n🔹 [PUT FORM] Request to: $fullUrl');
    print('🔸 Body: $body');
    print('🔸 Authorization Token: $token');

    final response = await _dio.put(
      fullUrl,
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print('✅ [PUT FORM] Response: ${response.data}');
    return response.data;
  }

  Future<Map<String, dynamic>> postWithHeaders({
    required String endPoint,
    Object? body,
    Map<String, String>? headers,
  }) async {
    final fullUrl = '$baseUrl/$endPoint';

    print('\n🔹 [POST With Headers] Request to: $fullUrl');
    print('🔸 Headers: $headers');
    print('🔸 Body: $body');

    final response = await _dio.post(
      fullUrl,
      data: body,
      options: Options(headers: headers),
    );

    print('✅ [POST With Headers] Response: ${response.data}');
    return response.data as Map<String, dynamic>;
  }

  delete({required String endPoint}) async {
    final fullUrl = '$baseUrl/$endPoint';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    print('\n🔹 [DELETE] Request to: $fullUrl');
    print('🔸 Authorization Token: $token');

    final response = await _dio.delete(
      fullUrl,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print('✅ [DELETE] Response: ${response.data}');
    return response.data;
  }
}
