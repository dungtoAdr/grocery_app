import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/screen/homepage/cart/shipping_method_screen.dart';
import 'package:grocery_app/screen/utils/data.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          List<Product> cart = value.cart;

          final cartProvider = Provider.of<CartProvider>(
            context,
            listen: false,
          );
          return cart.isEmpty
              ? Center(
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 150,
                      color: Colors.green,
                    ),
                    Text(
                      "Your cart is empty !",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "You will get a response within\na few minutes",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final product = cart[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: Card(
                            color: Colors.white,
                            child: Dismissible(
                              key: Key(product.id.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (direction) {
                                product.quantity = 0;
                                cartProvider.removeFromCart(index);
                                cartProvider.subTotal;
                                // setState(() {
                                //   // Data.product_cart[index].quantity = 0;
                                //   // Data.product_cart.removeAt(index);
                                //   total(cart);
                                // });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  left: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: CircleAvatar(
                                        child: Image.asset(product.image),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$${product.price.toString()}',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          product.weighed,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          color: Colors.green,
                                          onPressed: () {
                                            cartProvider.increaseQuantity(
                                              index,
                                            );
                                            // setState(() {});
                                            // product.quantity++;
                                          },
                                        ),
                                        Text(product.quantity.toString()),
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          color: Colors.green,
                                          onPressed: () {
                                            if (product.quantity == 1) {
                                              return;
                                            } else {
                                              // product.quantity--;
                                              cartProvider.decreaseQuantity(
                                                index,
                                              );
                                            }
                                            // setState(() {});
                                            cartProvider.subTotal;
                                            // total(cart);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${cartProvider.subTotal}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Shipping charges",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Text(
                                    cart.isEmpty ? "\$0.0" : "\$1.6",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    cart.isEmpty
                                        ? "\$0.0"
                                        : "\$${cartProvider.subTotal + 1.6}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10, bottom: 20),
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ShippingMethodScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Text(
                                        "Checkout",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }
}
