import 'package:flutter/material.dart';
import 'package:grocery_app/screen/utils/data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: Data.product_cart.length,
        itemBuilder: (context, index) {
          final product = Data.product_cart[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: Dismissible(
                key: Key(product.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  setState(() {
                    Data.product_cart[index].quantity = 0;
                    Data.product_cart.removeAt(index);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: CircleAvatar(child: Image.asset(product.image)),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${product.price.toString()}',
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            product.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                              setState(() {

                              });
                              product.quantity++;
                            },
                          ),
                          Text(product.quantity.toString()),
                          IconButton(
                            icon: Icon(Icons.remove),
                            color: Colors.green,
                            onPressed: () {
                              setState(() {

                              });
                              if (product.quantity == 1) {
                                return;
                              } else {
                                product.quantity--;
                              }
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
    );
  }
}
