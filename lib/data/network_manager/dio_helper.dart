import 'package:dio/dio.dart';
import '../exceptions/app_exceptions.dart';
import 'injection_container.dart';


class DioHelper {
  Dio dio = getDio();

  Options options = Options(
    receiveDataWhenStatusError: true,
    contentType: "application/json",
    responseType: ResponseType.json,
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  Map<String, dynamic> headers = {
    "isAuthRequired": "Bearer tokenhere",
    "x-api-key": "reqres-free-v1",
  };
  Future<dynamic> getApi({
    required String url,
    bool isAuthRequired = false,
  }) async {
    if (isAuthRequired) {
      options.headers = headers;
    }
    try {
      Response response = await dio.get(url, options: options);
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      throw FetchDataException(error.toString());
    }
  }

  Future<dynamic> postApi({
    required String url,
    bool isAuthRequired = false,
    Object? requestBody,
  }) async {
    if (isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if (requestBody == null) {
        response = await dio.post(url, options: options);
      } else {
        response = await dio.post(url, options: options, data: requestBody);
      }
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> putApi({
    required String url,
    bool isAuthRequired = false,
    Object? requestBody,
  }) async {
    if (isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if (requestBody == null) {
        response = await dio.put(url, options: options);
      } else {
        response = await dio.put(url, options: options, data: requestBody);
      }
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> patchApi({
    required String url,
    bool isAuthRequired = false,
    Object? requestBody,
  }) async {
    if (isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if (requestBody == null) {
        response = await dio.patch(url, options: options);
      } else {
        response = await dio.patch(url, options: options, data: requestBody);
      }
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> deleteApi({
    required String url,
    bool isAuthRequired = false,
    Object? requestBody,
  }) async {
    if (isAuthRequired) {
      options.headers = headers;
    }

    try {
      Response response;
      if (requestBody == null) {
        response = await dio.delete(url, options: options);
      } else {
        response = await dio.delete(url, options: options, data: requestBody);
      }
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      return null;
    }
  }

  void _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw RequestTimeoutException(error.message);
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['error']?.toString() ?? error.message;
        switch (statusCode) {
          case 400:
            throw BadRequestException(message);
          case 401:
            throw UnauthorizedException(message);
          case 403:
            throw ForbiddenException(message);
          case 404:
            throw NotFoundException(message);
          case 405:
            throw MethodNotAllowedException(message);
          case 429:
            throw TooManyRequestsException(message);
          case 500:
            throw InternalServerErrorException(message);
          case 503:
            throw ServiceUnavailableException(message);
          default:
            throw FetchDataException(message);
        }
      case DioExceptionType.cancel:
        throw FetchDataException('Request cancelled');
      case DioExceptionType.connectionError:
        throw NoInternetException('No internet connection');
      case DioExceptionType.badCertificate:
        throw FetchDataException('Bad certificate');
      case DioExceptionType.unknown:
        throw FetchDataException('Unknown error occurred');
    }
  }

  /// MULTIPART API
  Future<dynamic> multiPartRequest({
    required String url,
    required Object requestBody,
    bool isAuthRequired = false,
  }) async {
    Options option = Options(headers: {"Content-Type": "multipart/form-data"});

    try {
      Response response = await dio.post(
        url,
        data: requestBody,
        options: option,
      );
      return response.data;
    } on DioException catch (error) {
      _handleDioError(error);
    } catch (error) {
      return null;
    }
  }
}
