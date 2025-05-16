import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/screen/homepage/home/product_detail.dart';
import 'package:grocery_app/screen/utils/data.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(product: product),
            ),
          ),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.isNew == true
                ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  color: Colors.yellow[100],
                  child: Text(
                    'New',
                    style: TextStyle(color: Colors.yellow[700]),
                  ),
                )
                : const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Image.asset(
                    product.image,
                    height: 94,
                    width: 91,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(color: Colors.green),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.weighed,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      // if (Data.product_cart.isNotEmpty) {
                      //   for (int i = 0; i < Data.product_cart.length; i++) {
                      //     if (product.id == Data.product_cart[i].id) {
                      //       product.quantity++;
                      //       return;
                      //     }
                      //   }
                      // }
                      // Data.product_cart.add(product);
                      // product.quantity++;
                      Provider.of<CartProvider>(context,listen: false).addToCart(product, 1);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.shopping_bag_outlined, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
