import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/injection_container.dart' as di;
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/api/status_code.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try{
      final response = await client.get(path,queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    }on DioError catch(error) {
      _handleDioError(error);
    }

  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,bool formDataIsEnabled = false, Map<String, dynamic>? queryParameters}) async {
    try{
      final response = await client.post(path,queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!): body);
      return _handleResponseAsJson(response);
    }on DioError catch(error) {
      _handleDioError(error);
    }

  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    try{
      final response = await client.put(path,queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    }on DioError catch(error) {
      _handleDioError(error);
    }

  }

  dynamic _handleResponseAsJson(Response<dynamic> response){
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioError error){
    switch(error.type){
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.badCertificate:
        switch(error.response?.statusCode){
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectionError:
        throw const NoInternetConnectionException();
      case DioErrorType.unknown:
        break;
      case DioErrorType.badResponse:
        break;
    }
  }
}
