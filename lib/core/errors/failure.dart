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
    try {
      if (statusCode == 500) {
        return ServerFailure('There is a problem with the server, please try later');
      } else if (statusCode == 429) {
        final message = response['message'];
        if (message is Map) {
          return ServerFailure(
            CacheHelper.getData(key: TextConst.language) == "English"
                ? message['en']
                : message['ar'],
          );
        } else {
          return ServerFailure(message?.toString() ?? 'Too many requests');
        }
      } else if (statusCode == 409) {
        try {
          final message = jsonDecode(response['message']);
          return ServerFailure(
            CacheHelper.getData(key: TextConst.language) == "English"
                ? message['en']
                : message['ar'],
          );
        } catch (_) {
          return ServerFailure(response['message'] ?? 'Conflict occurred');
        }
      } else if ([400, 401, 403, 404].contains(statusCode)) {
        final msg = response['message'];
        if (msg is Map) {
          return ServerFailure(msg.toString());
        } else {
          return ServerFailure(msg?.toString() ?? 'Error occurred');
        }
      } else {
        return ServerFailure('Unexpected error with status: $statusCode');
      }
    } catch (e) {
      return ServerFailure('Unexpected response format: ${response.toString()}');
    }
  }

}
