import 'package:flutter/material.dart';
import 'package:learn_provider/product_details/product_details_controller.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductDetailsController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details View",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: controller.isLoading ? Column() : Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
