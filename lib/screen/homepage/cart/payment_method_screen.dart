import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/models/order_detail.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/providers/address_provider.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/order_provider.dart';
import 'package:grocery_app/providers/product_provider.dart';
import 'package:grocery_app/screen/home_page.dart';
import 'package:grocery_app/screen/homepage/cart/order_success_screen.dart';
import 'package:grocery_app/screen/homepage/home/product_detail.dart';
import 'package:grocery_app/screen/utils/data.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String address_id;

  const PaymentMethodScreen({super.key, required this.address_id});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool saveCard = false;

  Widget _buildStepIndicator(
    int step,
    String label,
    bool active,
    bool completed,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor:
              completed
                  ? Colors.green
                  : (active ? Colors.green : Colors.grey[300]),
          child:
              completed
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : Text(
                    step.toString(),
                    style: TextStyle(
                      color: active ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('Payment Method', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStepIndicator(1, "DELIVERY", false, true),
                _buildStepIndicator(2, "ADDRESS", false, true),
                _buildStepIndicator(3, "PAYMENT", true, false),
              ],
            ),
            SizedBox(height: 20),

            // Payment methods
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                paymentOption(Icons.account_balance_wallet, 'Paypal'),
                paymentOption(Icons.credit_card, 'Credit Card'),
                paymentOption(Icons.apple, 'Apple Pay'),
              ],
            ),
            SizedBox(height: 20),

            cardDisplay(),

            buildInputField(Icons.person, "Name on the card"),
            buildInputField(Icons.credit_card, "Card number"),
            Row(
              children: [
                Expanded(
                  child: buildInputField(Icons.date_range, "Month / Year"),
                ),
                SizedBox(width: 10),
                Expanded(child: buildInputField(Icons.lock, "CVV")),
              ],
            ),

            Row(
              children: [
                Switch(
                  value: saveCard,
                  onChanged: (val) {
                    setState(() => saveCard = val);
                  },
                  activeColor: Colors.green,
                ),
                Text("Save this card"),
              ],
            ),

            SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            final cartProvider = Provider.of<CartProvider>(
              context,
              listen: false,
            );
            final cart = cartProvider.cart;
            final order = Provider.of<OrderProvider>(context, listen: false);
            List<OrderDetail> details = [];
            for (int i = 0; i < cart.length; i++) {
              details.add(
                OrderDetail(
                  product_id: cart[i].id,
                  sub_total: cart[i].totalPrice(),
                  quantity: cart[i].quantity,
                ),
              );
            }
            await order.addOrder(
              Order(
                uid: FirebaseAuth.instance.currentUser!.uid,
                address_id: int.parse(widget.address_id),
                status: 1,
                total: cartProvider.subTotal,
                details: details,
              ),
            );
            cartProvider.removeAll();
            // Data.product_cart.clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => OrderSuccessScreen()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text("Make a payment"),
        ),
      ),
    );
  }

  Widget stepItem(String title, bool done, {int? number}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.green,
          child:
              done
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : Text('$number', style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget paymentOption(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
          ),
          child: Icon(icon, size: 30, color: Colors.black),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget cardDisplay() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [Colors.green.shade400, Colors.green]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fake logo circles
          Row(
            children: [
              CircleAvatar(radius: 10, backgroundColor: Colors.red),
              SizedBox(width: 8),
              CircleAvatar(radius: 10, backgroundColor: Colors.orange),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "XXXX XXXX XXXX 8790",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("CARD HOLDER", style: TextStyle(color: Colors.white70)),
                  Text("RUSSELL AUSTIN", style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("EXPIRES", style: TextStyle(color: Colors.white70)),
                  Text("01 / 22", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInputField(IconData icon, String hintText) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
