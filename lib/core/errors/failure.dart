import 'dart:convert';

import 'package:dio/dio.dart';

import '../../common/helper/cach_helper/cach_helper.dart';
import '../constants/const.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            statusCode: e.response?.statusCode, response: e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse({int? statusCode, dynamic response}) {
    if (statusCode == 500) {
      return ServerFailure('There is a problem with server, please try later');
    } else if (statusCode == 429) {
      return ServerFailure(
          CacheHelper.getData(key: TextConst.language) == "English"
              ? response['message']['en']
              : response['message']['ar']);
    } else if (statusCode == 409) {
      Map<String, dynamic> messageMap = jsonDecode('${response['message']}');
      return ServerFailure(
          CacheHelper.getData(key: TextConst.language) == "English"
              ? messageMap['en']
              : messageMap['ar']);
    } else if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 404) {
      print(response['message']);
      if (response['message'] is Map<String, dynamic>) {
        dynamic data = response['message'];
        ;
        print(data['en']);
        print(data);
        return ServerFailure(data.toString());
      } else {
        return ServerFailure(response['message'] ?? "");
      }
    } else {
      return ServerFailure('There was an error please try again $statusCode');
    }
  }
}
