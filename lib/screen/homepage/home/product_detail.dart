import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/review.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/favorite_provider.dart';
import 'package:grocery_app/providers/review_provider.dart';
import 'package:grocery_app/screen/homepage/home/reviews_screen.dart';
import 'package:grocery_app/screen/utils/data.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  Product product;

  ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  double avgRate = 0.0;
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ReviewProvider>(context, listen: false).getReviews();
  }

  double calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 0;
    double sum = reviews.fold(0, (prev, element) => prev + element.rates);
    return sum / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: Consumer<ReviewProvider>(
        builder: (context, value, child) {
          List<Review> reviews = value.reviews;
          List<Review> reviewsFilter =
              reviews
                  .where((element) => element.product_id == widget.product.id)
                  .toList();
          avgRate = calculateAverageRating(reviewsFilter);
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  color: Colors.green[50],
                  height: 400,
                  width: 480,
                  child: Image.asset(widget.product.image, fit: BoxFit.contain),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 16.0,
                      right: 16.0,
                      bottom: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${widget.product.price.toString()}",
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            Consumer<FavoriteProvider>(
                              builder: (context, favoriteProvider, child) {
                                final isFav = favoriteProvider.isFavorite(
                                  widget.product.id.toString(),
                                );
                                return IconButton(
                                  onPressed: () {
                                    favoriteProvider.toggleFavorite(
                                      widget.product,
                                    );
                                  },
                                  icon: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: isFav ? Colors.red : Colors.black,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.product.weighed,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ReviewsScreen(id: widget.product.id),
                                ),
                              ),
                          child: Row(
                            children: [
                              Text(
                                avgRate.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 4),
                              RatingBarIndicator(
                                rating: avgRate,
                                itemBuilder:
                                    (context, index) =>
                                        Icon(Icons.star, color: Colors.amber),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '(${reviewsFilter.length} reviews)',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world's finest lemon for juicing",
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) quantity--;
                                      });
                                    },
                                  ),
                                  Container(
                                    width: 32,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              // if (Data.product_cart.isNotEmpty) {
                              //   for (int i = 0; i < Data.product_cart.length; i++) {
                              //     if (widget.product.id ==
                              //         Data.product_cart[i].id) {
                              //       widget.product.quantity += quantity;
                              //       return;
                              //     }
                              //   }
                              // }
                              // Data.product_cart.add(widget.product);
                              // widget.product.quantity += quantity;
                              Provider.of<CartProvider>(
                                context,
                                listen: false,
                              ).addToCart(widget.product, quantity);
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.fixed,
                                backgroundColor: Colors.transparent,
                                duration: Duration(seconds: 1),
                                content: AwesomeSnackbarContent(
                                  color: Colors.green,
                                  title: 'Giỏ hàng',
                                  message:
                                      'Thêm sản phẩm vào giỏ hàng thành công',
                                  contentType: ContentType.success,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("Add to cart"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
