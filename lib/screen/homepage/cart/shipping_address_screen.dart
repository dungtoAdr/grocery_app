import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/address.dart';
import 'package:grocery_app/providers/address_provider.dart';
import 'package:grocery_app/screen/homepage/cart/payment_method_screen.dart';
import 'package:provider/provider.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  String? _selectedAddressId;
  Address? _selectedAddress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false).getAddress();
    });
  }

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

  void _onNext() {
    if (_selectedAddressId == null || _selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an address.")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PaymentMethodScreen(
              address_id: _selectedAddress!.id.toString(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipping Address"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Step Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStepIndicator(1, "DELIVERY", false, true),
                _buildStepIndicator(2, "ADDRESS", true, false),
                _buildStepIndicator(3, "PAYMENT", false, false),
              ],
            ),
          ),
          Expanded(
            child: Consumer<AddressProvider>(
              builder: (context, value, child) {
                List<Address> addresses = value.addresses;
                List<Address> userAddresses =
                    addresses
                        .where(
                          (element) => element.user_uid!.contains(
                            FirebaseAuth.instance.currentUser!.uid,
                          ),
                        )
                        .toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: userAddresses.length,
                  itemBuilder: (context, index) {
                    Address currentAddress = userAddresses[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAddressId = currentAddress.id.toString();
                          _selectedAddress = currentAddress;
                        });
                        print(
                          "Selected address: ${currentAddress.name}, ${currentAddress.address}",
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _selectedAddressId ==
                                        currentAddress.id.toString()
                                    ? Colors.green
                                    : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  currentAddress.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentAddress.address),
                                    Text(
                                      "${currentAddress.city}, ${currentAddress.country} ${currentAddress.zipcode}",
                                    ),
                                    Text(currentAddress.phone),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ElevatedButton(
              onPressed: _onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
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
