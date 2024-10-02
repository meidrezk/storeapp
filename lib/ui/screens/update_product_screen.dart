import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/services/update_product_service.dart';
import 'package:storeapp/ui/widgets/custom_button.dart';

import '../../models/product_model.dart';
import '../../routes_manager.dart';
import '../widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  String? productName, description, image, price;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: const Text("Update Product"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: "product name",
                onChanged: (value) {
                  productName = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "description",
                onChanged: (value) {
                  description = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "price",
                onChanged: (value) {
                  price = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(hintText: "image"),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                text: "Update",
                buttonColor: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    isLoading = true;
                    setState(() {});
                
                    await UpdateProduct();
                    print("success");
                    context.push(AppRouter.initialPath,);
                  } catch (e) {
                    print(e.toString());
                  }
                  isLoading = false;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> UpdateProduct() async =>
      await UpdateProductService().updateProduct(
        title: productName == null ? widget.product.title : productName!,
        price: price == null ? widget.product.price : price!,
        description:
            description == null ? widget.product.description : description!,
        image: image == null ? widget.product.image : image!,
        category: widget.product.category,
        id: widget.product.id!,
      );
}
