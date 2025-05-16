import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/address.dart';
import 'package:grocery_app/providers/address_provider.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  children: [
                    _buildTextField(_nameController, 'Name', Icons.person),
                    _buildTextField(
                      _emailController,
                      'Email address',
                      Icons.email,
                    ),
                    _buildTextField(
                      _phoneController,
                      'Phone number',
                      Icons.phone,
                    ),
                    _buildTextField(
                      _addressController,
                      'Address',
                      Icons.location_on,
                    ),
                    _buildTextField(_zipController, 'Zip code', Icons.home),
                    _buildTextField(_cityController, 'City', Icons.map),
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await Provider.of<AddressProvider>(
                    context,
                    listen: false,
                  ).addAddress(
                    Address(
                      name: _nameController.text,
                      phone: _phoneController.text,
                      address: _addressController.text,
                      zipcode: int.parse(_zipController.text),
                      city: _cityController.text,
                      country: _selectedCountry.toString(),
                      user_uid: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Save", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
