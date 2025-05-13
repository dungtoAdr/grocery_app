import 'package:flutter/material.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController email = TextEditingController();
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Password Recovery'),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Forgot Password",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            Text("Lorem ipsum dolor sit amet, consetetur"),
            Text("sadipscing elitr, sed diam nonumy"),
            SizedBox(height: 30),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email Address",
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  auth.forgotPass(email.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  "Send link",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
