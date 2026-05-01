import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_provider/product_home_page/product_index_model.dart';

class ProductHomePageController extends ChangeNotifier {
  List<Products> _allProducts = [];
  List<Products> _filteredProducts = [];
  List<Products> _searchAllProduct = [];
  List<String> _categories = ['All'];
  String _selectedCategory = 'All';
  int _sliderIndex = 0;
  int _cartCount = 0;
  final Set<int> _wishlist = {};
  bool _isLoading = false;
  final Dio _dio = Dio();
  String? _errorMessage;

  List<Products> get allProducts => _allProducts;
  List<Products> get filteredProducts => _filteredProducts;
  List<Products> get searchAllProduct => _searchAllProduct;
  List<Products> get sliderProducts => _allProducts.take(4).toList();
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  int get sliderIndex => _sliderIndex;
  int get cartCount => _cartCount;
  bool get isLoading => _isLoading;
  Set<int> get wishlist => _wishlist;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get("https://dummyjson.com/products");

      if (response.statusCode == 200) {
        try {
          final List<dynamic> products = response.data["products"];
          _allProducts = products.map((e) => Products.fromJson(e)).toList();
          _searchAllProduct = products.map((e) => Products.fromJson(e)).toList();
          _filteredProducts = List.from(_allProducts);

          // Build category list from products
          final Set<String> cats = {'All'};
          for (final p in _allProducts) {
            if (p.category != null) cats.add(_capitalize(p.category!));
          }
          _categories = cats.toList();


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

  void selectCategory(String category) {
    _selectedCategory = category;
    if (category == 'All') {
      _filteredProducts = List.from(_allProducts);
    } else {
      _filteredProducts =
          _allProducts
              .where(
                (p) =>
            _capitalize(p.category ?? '') ==
                category,
          )
              .toList();
    }
    notifyListeners();
  }

  void setSliderIndex(int index) {
    _sliderIndex = index;
    notifyListeners();
  }

  void addToCart(Products product) {
    _cartCount++;
    notifyListeners();
  }

  void toggleWishlist(int productId) {
    if (_wishlist.contains(productId)) {
      _wishlist.remove(productId);
    } else {
      _wishlist.add(productId);
    }
    notifyListeners();
  }

  bool isWishlisted(int productId) => _wishlist.contains(productId);

  String _capitalize(String s) {
    String category = "";
    Set<dynamic> cats = {};
    cats.add(s);
    for(var element in cats){
      category = element;
    }
    //s.isEmpty ? s : s.toUpperCase();
    return category;
  }
}
