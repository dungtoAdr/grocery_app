import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/address.dart';
import 'package:grocery_app/providers/address_provider.dart';
import 'package:provider/provider.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  int defaultIndex = 0;
  int? expandedCardIndex;
  List<bool> makeDefaultSwitch = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false).getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Address"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add address screen
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Add address pressed")));
            },
          ),
        ],
      ),
      body: Consumer<AddressProvider>(
        builder: (context, value, child) {
          final addresses = value.addresses;
          final addressProvider = Provider.of<AddressProvider>(
            context,
            listen: false,
          );
          if (makeDefaultSwitch.length != addresses.length) {
            makeDefaultSwitch = List.generate(
              addresses.length,
              (i) => i == defaultIndex,
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final userAddresses =
                  addresses
                      .where((element) => element.user_uid == currentUser!.uid)
                      .toList();
              final address = userAddresses[index];
              final isExpanded = expandedCardIndex == index;

              final nameController = TextEditingController(text: address.name);
              final addressController = TextEditingController(
                text: address.address,
              );
              final cityController = TextEditingController(text: address.city);
              final zipController = TextEditingController(
                text: address.zipcode.toString(),
              );
              final countryController = TextEditingController(
                text: address.country,
              );
              final phoneController = TextEditingController(
                text: address.phone,
              );

              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.green),
                      title: Text(
                        address.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(address.address),
                          Text(
                            "${address.city}, ${address.country} ${address.zipcode}",
                          ),
                          Text(address.phone),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            expandedCardIndex = isExpanded ? null : index;
                          });
                        },
                      ),
                    ),
                    if (index == defaultIndex)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "DEFAULT",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(labelText: "Name"),
                            ),
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(labelText: "Address"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: cityController,
                                    decoration: InputDecoration(
                                      labelText: "City",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: zipController,
                                    decoration: InputDecoration(
                                      labelText: "Zip code",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: countryController,
                              decoration: InputDecoration(labelText: "Country"),
                            ),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: "Phone number",
                              ),
                            ),
                            SwitchListTile(
                              title: Text("Make default"),
                              value: makeDefaultSwitch[index],
                              onChanged: (val) {
                                setState(() {
                                  for (
                                    int i = 0;
                                    i < makeDefaultSwitch.length;
                                    i++
                                  ) {
                                    makeDefaultSwitch[i] = false;
                                  }
                                  makeDefaultSwitch[index] = val;
                                  if (val) defaultIndex = index;
                                });
                              },
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () async {
                                await addressProvider.updateAddress(
                                  Address(
                                    id: address.id,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                    zipcode: int.parse(zipController.text),
                                    city: cityController.text,
                                    country: countryController.text,
                                  ),
                                );
                              },
                              child: Text("Save settings"),
                            ),
                          ],
                        ),
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
