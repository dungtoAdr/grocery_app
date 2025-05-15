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
  final _formKey = GlobalKey<FormState>();
  bool _saveAddress = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  String? _selectedCountry;

  final List<String> _countries = ['USA', 'Vietnam', 'UK', 'Japan'];

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

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        return null;
      },
    );
  }

  void _onNext() {
    if (_saveAddress) {
      final userProvider = Provider.of<AddressProvider>(context, listen: false);
      final currentUser = FirebaseAuth.instance.currentUser;
      userProvider.addAddress(
        Address(
          name: _nameController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          zipcode: int.parse(_zipController.text),
          city: _cityController.text,
          country: _selectedCountry.toString(),
          user_uid: currentUser!.uid,
        ),
      );
    }
    if (_formKey.currentState!.validate() && _selectedCountry != null) {
      print("Address Saved: $_saveAddress");
      print("Country: $_selectedCountry");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipping Address"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_nameController, 'Name', Icons.person),
                    const SizedBox(height: 12),
                    _buildTextField(
                      _emailController,
                      'Email address',
                      Icons.email,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      _phoneController,
                      'Phone number',
                      Icons.phone,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      _addressController,
                      'Address',
                      Icons.location_on,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(_zipController, 'Zip code', Icons.home),
                    const SizedBox(height: 12),
                    _buildTextField(_cityController, 'City', Icons.map),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.public),
                        hintText: 'Country',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                      items:
                          _countries
                              .map(
                                (country) => DropdownMenuItem(
                                  value: country,
                                  child: Text(country),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (value) => setState(() => _selectedCountry = value),
                      validator:
                          (value) =>
                              value == null ? 'Please select a country' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Switch(
                          value: _saveAddress,
                          activeColor: Colors.green,
                          onChanged:
                              (value) => setState(() => _saveAddress = value),
                        ),
                        const Text("Save this address"),
                      ],
                    ),
                  ],
                ),
              ),
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
