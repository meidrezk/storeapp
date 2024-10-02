import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/services/get_all_products_service.dart';

import '../widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "New Trend",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(FontAwesomeIcons.cartPlus))
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: AllProductsService().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error fetching products ${snapshot.error}');
            return  Center(child: Text('Error fetching products ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 5,
                    childAspectRatio: .85),
                itemCount: products.length,
                itemBuilder: (context, index) => CustomCard(
                  product: products[index],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No products available'));
          }
        },
      ),
    );
  }
}
