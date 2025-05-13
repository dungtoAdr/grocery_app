import 'package:flutter/material.dart';
import 'package:grocery_app/screen/homepage/cart/shipping_address_screen.dart';

class ShippingMethodScreen extends StatefulWidget {
  const ShippingMethodScreen({super.key});

  @override
  State<ShippingMethodScreen> createState() => _ShippingMethodScreenState();
}

class _ShippingMethodScreenState extends State<ShippingMethodScreen> {
  int? _selectedMethod;

  final List<Map<String, dynamic>> _shippingOptions = [
    {
      'title': 'Standard Delivery',
      'desc':
          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
      'price': 3,
    },
    {
      'title': 'Next Day Delivery',
      'desc':
          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
      'price': 5,
    },
    {
      'title': 'Nominated Delivery',
      'desc':
          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
      'price': 3,
    },
  ];

  void _goToNextStep() {
    if (_selectedMethod != null) {
      final selected = _shippingOptions[_selectedMethod!];
      print("Đã chọn: ${selected['title']} - \$${selected['price']}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShippingAddressScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn phương thức giao hàng')),
      );
    }
  }

  Widget _buildStepIndicator(int step, String label, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: active ? Colors.green : Colors.grey[300],
          child: Text(
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

  Widget _buildShippingCard(int index) {
    final item = _shippingOptions[index];
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: _selectedMethod == index ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['desc'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${item['price']}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipping Method"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStepIndicator(1, "DELIVERY", true),
                _buildStepIndicator(2, "ADDRESS", false),
                _buildStepIndicator(3, "PAYMENT", false),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _shippingOptions.length,
              itemBuilder: (context, index) => _buildShippingCard(index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ElevatedButton(
              onPressed: _goToNextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Next", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
