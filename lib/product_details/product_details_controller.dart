import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_provider/product_details/product_details_model.dart';

class ProductDetailsController extends ChangeNotifier {
  bool _isLoading = false;
  final Dio _dio = Dio();
  String? _errorMessage;
  ProductDetails _productDetails = ProductDetails();

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  ProductDetails get productDetails => _productDetails;

  Future<void> fetchProductDetails({required int id}) async {
    // Guard — prevent duplicate calls
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.get("https://dummyjson.com/products/$id");
      _productDetails = ProductDetails.fromJson(response.data);

      if (response.statusCode == 200) {
        try {} catch (e) {
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

    notifyListeners();
  }
}
