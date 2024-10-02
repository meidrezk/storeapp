import 'package:dio/dio.dart';
import 'package:storeapp/constant.dart';

class AllCategoriesService {
  final Dio dio = Dio();

  Future<List<String>> getAllCategories() async {
    try {
      Response response =
          await dio.get('${Constant.baseurl}/products/categories');
      if (response.statusCode == 200) {
        List<String> categories = (response.data);
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } on DioException catch (dioError) {
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
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
