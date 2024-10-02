import 'package:dio/dio.dart';
import 'package:storeapp/constant.dart';
import 'package:storeapp/helper/api.dart';
import '../models/product_model.dart';

class AllProductsService {


  Future<List<Product>> getAllProducts() async {
Response<dynamic>response=await Api().get(url: '${Constant.baseurl}/products');
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;

  }
}
