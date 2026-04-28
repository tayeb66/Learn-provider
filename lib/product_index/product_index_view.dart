import 'package:flutter/material.dart';
import 'package:learn_provider/Routes/app_routes.dart';
import 'package:learn_provider/product_index/product_index_provider.dart';
import 'package:provider/provider.dart';

class ProductIndexView extends StatelessWidget {
  const ProductIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Index View",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.productList.length,
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.productDetails, arguments: {"id": product.id});
                            },
                            child: Card(
                              child: ListTile(
                                leading: Text(product.title.toString()),
                                trailing: Text("\$${product.price.toString()}"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
