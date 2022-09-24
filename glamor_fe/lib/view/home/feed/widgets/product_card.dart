import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/constants/navigation/navigation_constants.dart';
import 'package:client/core/init/navigation/navigation_service.dart';
import 'package:client/product/extension/string_extension.dart';
import 'package:client/product/utility/image/project_network_image.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

/* class ProductCard extends StatefulWidget {
  final Product? product;
  const ProductCard({super.key, this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return buildImageInteractionCard(context);
  }

  
}
 */
class ProductCard extends StatelessWidget {
  final Product? product;
  const ProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const SizedBox.shrink()
        : buildImageInteractionCard(product!);
  }
}

Widget buildImageInteractionCard(Product product) {
  return GestureDetector(
    onTap: () {
      NavigationService.instance.navigateToPage(
          path: NavigationConstants.PRODUCT_VIEW, data: product);
    },
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /* Product Image*/
          Stack(
            children: [
              SizedBox(
                height: 100,
                child: ProjectNetworkImage(
                  src: product.image.toString(),
                ),
              ),
            ],
          ),
          /* Product Title*/
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(
              product.title.toString().constrict(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          /* Product Rate*/
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                child: Text('${product.rating!.rate}⭐'),
                onPressed: () {},
              ),
              /* Product Price*/
              TextButton(
                child: Text('${product.price} TL'),
                onPressed: () {},
              )
            ],
          ),
          /* Product Seller Location */
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
            child: Row(
              children: const [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                ),
                Text(
                  'TUZLA, ISTANBUL',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}