import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/models/order_detail.dart';
import 'package:grocery_app/providers/order_provider.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  Set<int> expandedOrders = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderProvider>(
        context,
        listen: false,
      ).getOrders(FirebaseAuth.instance.currentUser!.uid.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: Consumer<OrderProvider>(
        builder: (context, value, child) {
          List<Order> orders = value.orders;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];
              List<OrderDetail> orderDetails = order.details;
              bool isExpanded = expandedOrders.contains(order.id);

              return Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Order ID: ${order.id}"),
                      subtitle: Text("Address ID: ${order.total.toString()}"),
                      trailing: IconButton(
                        icon: Icon(isExpanded ? Icons.remove : Icons.add),
                        onPressed: () {
                          setState(() {
                            if (isExpanded) {
                              expandedOrders.remove(order.id);
                            } else {
                              expandedOrders.add(order.id!);
                            }
                          });
                        },
                      ),
                    ),
                    if (isExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderDetails.length,
                        itemBuilder: (context, detailIndex) {
                          final detail = orderDetails[detailIndex];
                          return ListTile(
                            leading: Image.network(
                              detail.product_image!,
                              width: 40,
                              height: 40,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Image.asset(detail.product_image!,width: 50,height: 50,),
                            ),
                            title: Text(detail.product_name!),
                            subtitle: Text(
                              "Quantity: ${detail.quantity} | Subtotal: \$${detail.sub_total}",
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
