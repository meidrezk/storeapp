import 'package:dio/dio.dart';

class Api {
  final Dio dio = Dio();

  // GET request with token
  Future<Response<dynamic>> get({
    required String url,
    String? token, // Token added here
  }) async {
    // Initialize headers map
    Map<String, String> headers = {};

    // Add token to headers if it's provided
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      // Perform the GET request with headers
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load response');
      }
    } on DioException catch (dioError) {
      _handleDioError(dioError);
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // POST request with additional attributes and token
  Future<Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? data,
    String? token, // Token added here
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    // Initialize headers map
    Map<String, String> headers = {};

    // Add token to headers if it's provided
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    // Combine headers with options if provided
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(headers: {
      ...headers, // Add token to existing headers
      ...?requestOptions.headers, // Include any additional headers
    });

    try {
      Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to load response');
      }
    } on DioException catch (dioError) {
      _handleDioError(dioError);
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response<dynamic>> put({
    required String url,
    Map<String, dynamic>? data,
    String? token, // Token added here
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    // Initialize headers map
    Map<String, String> headers = {};
    headers.addAll({"Content-Type": "application/x-www-form-urlencoded"});

    // Add token to headers if it's provided
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    // Combine headers with options if provided
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(headers: {
      ...headers, // Add token to existing headers
      ...?requestOptions.headers, // Include any additional headers
    });

    try {
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("==============url update request: $url");
        print("============== update response: $response");
        return response;

      } else {
        throw Exception('Failed to load response');
      }
    } on DioException catch (dioError) {
      _handleDioError(dioError);
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Handling Dio errors in a separate method
  void _handleDioError(DioException dioError) {
    if (dioError.type == DioExceptionType.connectionTimeout) {
      throw Exception('Connection timeout occurred.');
    } else if (dioError.type == DioExceptionType.receiveTimeout) {
      throw Exception('Receive timeout in connection with API server.');
    } else if (dioError.type == DioExceptionType.badResponse) {
      throw Exception(
          'Received invalid status code: ${dioError.response?.statusCode}');
    } else if (dioError.type == DioExceptionType.cancel) {
      throw Exception('Request to API server was cancelled.');
    } else {
      throw Exception('Unexpected error occurred: $dioError');
    }
  }
}
