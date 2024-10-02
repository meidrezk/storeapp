import 'package:dio/dio.dart';

import '../constant.dart';
import '../helper/api.dart';
import '../models/product_model.dart';

class AddProductService {
  Future<List<Product>> addProduct(
      {required String title,
        required String price,
        required String description,
        required String image,
        required String category}) async {
    Response<dynamic> response =
        await Api().post(url: "${Constant.baseurl}/products", data: {
      "title": title,
      "price": price,
      "description": description,
      "image": image,
      "category": category
    });
    List<Product> products = (response.data as List)
        .map((product) => Product.fromJson(product))
        .toList();
    return products;
  }
}
