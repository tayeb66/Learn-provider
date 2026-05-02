import 'package:flutter/material.dart';
import 'package:learn_provider/product_details/product_details_controller.dart';
import 'package:learn_provider/product_details/widgets/action_buttons_widget.dart';
import 'package:learn_provider/product_details/widgets/image_gallery_widget.dart';
import 'package:learn_provider/product_details/widgets/meta_widget.dart';
import 'package:learn_provider/product_details/widgets/policies_widget.dart';
import 'package:learn_provider/product_details/widgets/product_description_widget.dart';
import 'package:learn_provider/product_details/widgets/product_header_widget.dart';
import 'package:learn_provider/product_details/widgets/product_info_widget.dart';
import 'package:learn_provider/product_details/widgets/reviews_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 1: Get productId from route
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productId = args["id"] ?? 0;

    // Step 2: Fetch data once after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductDetailsController>(
        context,
        listen: false,
      ).fetchProductDetails(id: productId);
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
        body: controller.isLoading == false
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageGalleryWidget(
                        images: controller.productDetails.images,
                        thumbnail: controller.productDetails.thumbnail,
                      ),
                      ProductHeaderWidget(
                        title: controller.productDetails.title,
                        brand: controller.productDetails.brand,
                        sku: controller.productDetails.sku,
                        price: controller.productDetails.price,
                        discountPercentage:
                            controller.productDetails.discountPercentage,
                        rating: controller.productDetails.rating,
                        tags: controller.productDetails.tags,
                        availabilityStatus:
                            controller.productDetails.availabilityStatus,
                      ),
                      ProductDescriptionWidget(
                        description: controller.productDetails.description,
                      ),
                      ProductInfoWidget(
                        category: controller.productDetails.category,
                        weight: controller.productDetails.weight,
                        stock: controller.productDetails.stock,
                        minimumOrderQuantity:
                            controller.productDetails.minimumOrderQuantity,
                        dimensions: controller.productDetails.dimensions,
                      ),
                      PoliciesWidget(
                        warrantyInformation:
                            controller.productDetails.warrantyInformation,
                        shippingInformation:
                            controller.productDetails.shippingInformation,
                        returnPolicy: controller.productDetails.returnPolicy,
                      ),
                      MetaWidget(meta: controller.productDetails.meta),
                      ReviewsWidget(reviews: controller.productDetails.reviews),
                      const SizedBox(height: 24),
                      ActionButtonsWidget(
                        onAddToCart: () {},
                        onAddToWishlist: () {},
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Center(child: Icon(Icons.front_loader,size: 100,)),
                  ),
                ),
              ),
      ),
    );
  }
}
