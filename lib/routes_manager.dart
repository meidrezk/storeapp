import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/ui/screens/home_page.dart';
import 'package:storeapp/ui/screens/update_product_screen.dart';

class AppRouter {
  static const String initialPath = "/";
  static const String updateProductScreenPath = "/updateProductScreenPath";


  static GoRouter router() => GoRouter(
    routes: [
      GoRoute(
        path: initialPath,
        builder: (context, state) =>  const HomePage(),
      ),
      GoRoute(
        path: updateProductScreenPath,
        builder: (context, state) {
          final Object? product = state.extra;
          return UpdateProductScreen(product: product as Product,);
        },
      ),


  ],
  );
}