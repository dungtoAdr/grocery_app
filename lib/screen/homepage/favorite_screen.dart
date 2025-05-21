import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/providers/favorite_provider.dart';
import 'package:grocery_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final allProducts =
        Provider.of<ProductProvider>(context, listen: false).products;
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        List<Product> favoriteProducts =
            allProducts
                .where(
                  (product) => favoriteProvider.favoriteProductIds.contains(
                    product.id.toString(),
                  ),
                )
                .toList();

        if (favoriteProducts.isEmpty) {
          return Center(child: Text('Bạn chưa có sản phẩm yêu thích nào'));
        }

        return ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            Product product = favoriteProducts[index];
            return Card(
              child: ListTile(
                leading: Image.asset(product.image, width: 50, height: 50),
                title: Text(product.name),
                subtitle: Text('\$${product.price.toString()}'),
                trailing: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    favoriteProvider.removeFavorite(product.id.toString());
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
