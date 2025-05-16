import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/address.dart';
import 'package:grocery_app/providers/address_provider.dart';
import 'package:grocery_app/screen/homepage/account/add_address_screen.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressProvider>(context, listen: false).getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Địa chỉ của tôi"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAddressScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<AddressProvider>(
        builder: (context, value, child) {
          final allAddresses = value.addresses;
          final userAddresses =
              allAddresses
                  .where((address) => address.user_uid == currentUser?.uid)
                  .toList();

          if (makeDefaultSwitch.length != userAddresses.length) {
            makeDefaultSwitch = List.generate(
              userAddresses.length,
              (i) => i == defaultIndex,
            );
          }

          if (userAddresses.isEmpty) {
            return Center(child: Text("Bạn chưa có địa chỉ nào."));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: userAddresses.length,
            itemBuilder: (context, index) {
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
                              "MẶC ĐỊNH",
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
                              decoration: InputDecoration(labelText: "Họ tên"),
                            ),
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(labelText: "Địa chỉ"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: cityController,
                                    decoration: InputDecoration(
                                      labelText: "Thành phố",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: zipController,
                                    decoration: InputDecoration(
                                      labelText: "Mã bưu điện",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: countryController,
                              decoration: InputDecoration(
                                labelText: "Quốc gia",
                              ),
                            ),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: "Số điện thoại",
                              ),
                            ),
                            SwitchListTile(
                              title: Text("Đặt làm mặc định"),
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
                                await Provider.of<AddressProvider>(
                                  context,
                                  listen: false,
                                ).updateAddress(
                                  Address(
                                    id: address.id,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                    zipcode: int.parse(zipController.text),
                                    city: cityController.text,
                                    country: countryController.text,
                                    user_uid: currentUser!.uid,
                                  ),
                                );
                                setState(() {
                                  expandedCardIndex = null;
                                });
                              },
                              child: Text("Lưu thay đổi"),
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
