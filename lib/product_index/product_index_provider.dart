import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_provider/product_index/product_index_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Products> _productList = <Products>[];
  bool _isLoading = false;
  final Dio _dio = Dio();
  String? _errorMessage;

  List<Products> get productList => _productList;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get("https://dummyjson.com/products");

      if (response.statusCode == 200) {
        try {
          final List<dynamic> products = response.data["products"];
          _productList = products.map((e) => Products.fromJson(e)).toList();
        } catch (e) {
          if (kDebugMode) {
            print("Mapping failed: $e");
          }
        }
      }
    } on DioException catch (e) {
      _errorMessage = e.message ?? "An unexpected error occurred";
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
