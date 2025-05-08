import 'package:flutter/material.dart';
import 'package:grocery_app/screen/auth/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Colors.white,
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'assets/welcome_img.png',
              height: 638,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        "Welcome",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      subtitle: Text(
                        "Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          elevation: 2,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              widthFactor: 13,
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/ic_google.png',
                                height: 24,
                              ),
                            ),
                            Text(
                              "Continue with Google",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(isLogin: false),
                            ),
                          );
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
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              widthFactor: 13,
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/ic_person.png',
                                height: 24,
                              ),
                            ),
                            Text(
                              "Create an account",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AuthScreen(isLogin: true),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
