import 'package:dio/dio.dart';
import '../../common/helper/cach_helper/cach_helper.dart';
import '../constants/app_urls.dart';
import '../constants/const.dart';

class ApiService {
  final Dio _dio;

  final String baseUrl = AppUrl.baseUrl;

  ApiService(this._dio);

  get({required String endPoint, Map<String, dynamic>? params}) async {
    print('$baseUrl/$endPoint');
    Response response = await _dio.get('$baseUrl/$endPoint',
        queryParameters: params,
        options: Options(headers: {
          "Authorization":
              "Bearer ${CacheHelper.getData(key: TextConst.userToken) ?? ""}"
        }));
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint,
      Object? body,
      Map<String, dynamic>? params}) async {
    print(CacheHelper.getData(key: TextConst.userToken));
    print('$baseUrl/$endPoint');

    Response response = await _dio.post(
      '$baseUrl/$endPoint',
      queryParameters: params,
      data: body,
      options: Options(headers: {
        "Authorization":
            "Bearer ${CacheHelper.getData(key: TextConst.userToken) ?? ""}",
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }),
    );
    return response.data;
  }

  postFormData({required String endPoint, required body}) async {
    Response response = await _dio.post('$baseUrl/$endPoint',
        data: FormData.fromMap(body),
        options: Options(headers: {
          "Authorization":
              "Bearer ${CacheHelper.getData(key: TextConst.userToken) ?? ""}",
          // 'Content-Type': 'application/json',
          // 'Accept': 'application/json',
        }));
    return response.data;
  }

  putFormData({required String endPoint, required body}) async {
    print("$baseUrl/$endPoint");
    Response response = await _dio.put(
      '$baseUrl/$endPoint',
      data: body,
      options: Options(headers: {
        "Authorization":
            "Bearer ${CacheHelper.getData(key: TextConst.userToken) ?? ""}",
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }),
    );
    return response.data;
  }

  delete({required String endPoint}) async {
    Response response = await _dio.delete('$baseUrl/$endPoint',
        options: Options(headers: {
          "Authorization":
              "Bearer ${CacheHelper.getData(key: TextConst.userToken) ?? ""}",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    return response.data;
  }
}
