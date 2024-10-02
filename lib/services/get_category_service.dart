import 'package:dio/dio.dart';
import 'package:storeapp/constant.dart';
import '../helper/api.dart';
import '../models/product_model.dart';

class GetCategoryService {
  final Api api = Api();

  Future<List<Product>> getProductsByCategory(String categoryName) async {
    Response<dynamic> response = await api.get(
        url: '${Constant.baseurl}/products/category/$categoryName');

    if (response.data is List) {
      List<Product> products = (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();
      return products;
    } else {
      throw Exception('Invalid data format');
    }
  }
}
