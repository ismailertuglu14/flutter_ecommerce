import 'package:client/core/constants/navigation/navigation_constants.dart';
import 'package:client/view/_product/widgets/card/product_card.dart';
import 'package:client/view/home/feed/model/product_model.dart';
import 'package:client/view/home/feed/service/product_notifier.dart';
import 'package:client/view/home/feed/viewmodel/feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});
  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends FeedViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildScaffold());
  }

  Widget _buildScaffold() {
    final List<Product> products =
        Provider.of<ProductNotifier>(context).productList;

    return ChangeNotifierProvider(
      create: (context) => ProductNotifier(),
      child: Builder(
        builder: (context) {
          //  final provider = Provider.of<ProductNotifier>(context);
          if (products.isEmpty) {
            return _buildProductLoading();
          }
          return _buildProductList(products);
        },
      ),

      // body: FutureBuilder<List<Product>>(
      //   future: ProductService(VexanaManager.instance.networkManager)
      //       .fetchProducts(),
      //   builder: ((context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return _buildProductLoading();
      //     } else if (snapshot.hasData) {
      //       var list = snapshot.data;
      //       return _buildProductList(list!);
      //     } else {
      //       return _buildProductError();
      //     }
      //   }),
      // ),
      //.
    );
  }

  Center _buildProductLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProductList(List<Product> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4)
          .copyWith(bottom: 1),
      child: SingleChildScrollView(
        key: const PageStorageKey<String>('feed'),
        child: Column(
          children: [
            _buildTextField(),
            MasonryGridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 20),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: list[index],
                );
              },
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
            ),
          ],
        ),
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(letterSpacing: 3),
        suffixIcon: GestureDetector(
          onTap: () {
            navigation.navigateToPage(path: NavigationConstants.CATEGORY);
          },
          child: const Icon(Icons.format_list_numbered_rtl_sharp),
        ),
      ),
    );
  }
}
