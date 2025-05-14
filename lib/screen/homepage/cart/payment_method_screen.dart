import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page.dart';
import 'package:grocery_app/screen/homepage/cart/order_success_screen.dart';
import 'package:grocery_app/screen/utils/data.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool saveCard = false;

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
            // Step indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                stepItem("DELIVERY", true),
                stepItem("ADDRESS", true),
                stepItem("PAYMENT", true, number: 3),
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

            // Credit Card UI
            cardDisplay(),

            // Input fields
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

            // Save card toggle
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

            SizedBox(height: 100), // Để không che mất phần trên khi cuộn
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Processing payment...')));
            Data.product_cart.clear();
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
