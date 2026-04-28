import 'package:flutter/material.dart';
import 'package:learn_provider/Routes/app_routes.dart';
import 'package:learn_provider/product_details/product_details_controller.dart';
import 'package:learn_provider/product_details/product_details_view.dart';
import 'package:learn_provider/product_index/product_index_provider.dart';
import 'package:learn_provider/product_index/product_index_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()..fetchProducts()),
        ChangeNotifierProvider(create: (context) => ProductDetailsController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.productIndex,
      routes: {
        Routes.productIndex: (context) => ProductIndexView(),
        Routes.productDetails: (context) => ProductDetailsView(),
      },
    );
  }
}
