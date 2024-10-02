import 'package:dio/dio.dart';

import '../constant.dart';
import '../helper/api.dart';
import '../models/product_model.dart';

class UpdateProductService{
  Future<List<Product>> updateProduct(
      {required String title,
      required dynamic id,
        required String price,
        required String description,
        required String image,
        required String category}) async {
    Response<dynamic> response =
    await Api().put(url: "${Constant.baseurl}/products/$id", data: {
      "title": title,
      "price": price,
      "description": description,
      "image": image,
      "category": category
    },);
    List<Product> products = (response.data as List)
        .map((product) => Product.fromJson(product))
        .toList();

    print("==============products: $products");
    print("==============product id: $id");
    return products;
  }
}