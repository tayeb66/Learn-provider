import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_provider/product_details/product_details.dart';

class ProductDetailsController extends ChangeNotifier {
  bool _isLoading = false;
  final Dio _dio = Dio();
  String? _errorMessage;
  final ProductDetails _productDetails = ProductDetails();
  final Map<String,dynamic> _argumentsData = {};

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ProductDetails get productDetails => _productDetails;
  Map<String,dynamic> get argumentsData => _argumentsData;

  Future<void> fetchProductDetails() async{
    _isLoading = true;
    notifyListeners();

    try{
      final response = await _dio.get("https://dummyjson.com/products/${_argumentsData["id"]}");

      if(response.statusCode == 200){
        try {

        } catch (e) {
          if (kDebugMode) {
            print("Mapping failed: $e");
          }
        }
      }

    }on DioException catch (e){
      _errorMessage = e.message ?? "An unexpected error occurred";
    }catch(e){
      _errorMessage = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}