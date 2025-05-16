import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/models/profile_user.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _gmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getUsers();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _gmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About me"), centerTitle: true),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          final users = value.users;
          final currentUser = FirebaseAuth.instance.currentUser;
          final userProvider = Provider.of<UserProvider>(
            context,
            listen: false,
          );
          ProfileUser user = users.firstWhere(
            (element) => element.uid.contains(currentUser!.uid),
          );
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _nameController,
                    enabled: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      hintText: user.name,
                    ),
                  ),
                  TextFormField(
                    controller: _gmailController,
                    readOnly: true,
                    enabled: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      hintText: user.gmail,
                    ),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    enabled: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                      hintText: user.phone,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Change Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    enabled: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Current password",
                    ),
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      hintText: "● ● ● ● ● ● ● ● ●",
                    ),
                  ),
                  TextField(
                    enabled: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Confirm password",
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await userProvider.updateUser(
                          ProfileUser(
                            name:
                                _nameController.text == ''
                                    ? user.name
                                    : _nameController.text,
                            gmail: user.gmail,
                            phone:
                                _phoneController.text == ''
                                    ? user.phone
                                    : _phoneController.text,
                            uid: user.uid,
                          ),
                        );
                        _formKey.currentState!.reset();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text("Save settings"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
