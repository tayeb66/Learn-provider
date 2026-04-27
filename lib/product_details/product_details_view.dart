import 'package:flutter/material.dart';
import 'package:learn_provider/product_details/product_details_controller.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 1: Get productId from route
    final args      = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productId = args["id"] ?? 0;

    // Step 2: Fetch data once after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductDetailsController>(context, listen: false)
          .fetchProductDetails(id: productId);
    });

    return Consumer<ProductDetailsController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Product Details View",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: controller.isLoading == false 
              ? Column(
            children: [
              Text("${controller.productDetails.description}")
            ],
          )
              : Center(child: CircularProgressIndicator(),),
        ),
      ),
    );
  }
}
