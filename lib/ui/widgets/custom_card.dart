import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/models/product_model.dart';

import '../../routes_manager.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.product, });
 final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(      onTap: () {
      context.push(AppRouter.updateProductScreenPath,extra: product);
    },
      child: Card(elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.network(
                    product.image,
                width: 100,
                height: 100,
              )),
              Text(
                product.title.substring(0,6),
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    r"$" "${product.price}",
                    style: const TextStyle(fontSize: 15),
                  ), const Icon(Icons.favorite,color: Colors.grey,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
