import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:grocery_app/models/profile_user.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:grocery_app/screen/auth/welcome_screen.dart';
import 'package:grocery_app/screen/homepage/account/about_me_screen.dart';
import 'package:grocery_app/screen/homepage/account/my_address_screen.dart';
import 'package:grocery_app/screen/homepage/account/my_order_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getUsers();
    });
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profile_image_path');

    if (savedPath != null && File(savedPath).existsSync()) {
      setState(() {
        _image = File(savedPath);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', pickedFile.path);
    } else {
      print("Không chọn ảnh nào.");
    }
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Consumer<UserProvider>(
          builder: (context, value, child) {
            final users = value.users;
            final currentUser = FirebaseAuth.instance.currentUser;
            ProfileUser user = users.firstWhere(
              (element) => element.uid.contains(currentUser!.uid),
              orElse:
                  () => ProfileUser(
                    name: "abc",
                    gmail: "abc@gmai.com",
                    phone: "09905032003",
                    uid: "asdasldkjlka",
                  ),
            );
            return Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        child: ClipOval(
                          child:
                              _image != null
                                  ? Image.file(_image!, fit: BoxFit.cover)
                                  : Container(
                                    color: Colors.grey[300],
                                    child: const Center(child: Text("Ảnh")),
                                  ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: Container(
                          height: 25,
                          width: 25,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: _pickImage,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(user.gmail, style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildMenuItem(Icons.person_outline, "About me", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutMeScreen(),
                          ),
                        );
                      }),
                      _buildMenuItem(
                        Icons.inventory_2_outlined,
                        "My Orders",
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderScreen(),));
                        },
                      ),
                      _buildMenuItem(
                        Icons.favorite_border,
                        "My Favorites",
                        () {},
                      ),
                      _buildMenuItem(
                        Icons.location_on_outlined,
                        "My Address",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAddressScreen(),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(Icons.credit_card, "Credit Cards", () {}),
                      _buildMenuItem(
                        Icons.receipt_long_outlined,
                        "Transactions",
                        () {},
                      ),
                      _buildMenuItem(
                        Icons.notifications_none,
                        "Notifications",
                        () {},
                      ),
                      _buildMenuItem(
                        Icons.logout_outlined,
                        "Sign out",
                        () async {
                          await auth.logout();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
