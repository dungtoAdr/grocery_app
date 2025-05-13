import 'package:flutter/material.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About me"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                hintText: "Dung To",
              ),
            ),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                hintText: "tdungvippro112@gmail.com",
              ),
            ),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                hintText: "0905032003",
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
                onPressed: () {},
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
  }
}
