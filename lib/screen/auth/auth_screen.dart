import 'package:flutter/material.dart';
import 'package:grocery_app/screen/auth/forgot_screen.dart';
import 'package:grocery_app/screen/home_page.dart';

class AuthScreen extends StatefulWidget {
  bool isLogin;

  AuthScreen({super.key, required this.isLogin});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isShowPass = true;

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
              widget.isLogin ? 'assets/login_img.png' : 'assets/signup_img.png',
              height: 537,
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
                        widget.isLogin ? "Welcome back !" : "Create account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      subtitle: Text(
                        widget.isLogin
                            ? "Sign in to your account"
                            : "Quickly create account",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          spacing: 10,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Email Address",
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            !widget.isLogin
                                ? TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Phone number",
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                )
                                : SizedBox(),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "● ● ● ● ● ● ● ● ●",
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isShowPass = !isShowPass;
                                    });
                                  },
                                  icon: Icon(
                                    isShowPass
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                  ),
                                ),
                              ),
                              obscureText: isShowPass,
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.isLogin
                        ? Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot password",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        )
                        : SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.isLogin
                              ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              )
                              : print("signup");
                          _formKey.currentState!.reset();
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
                        child: Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              widget.isLogin ? "Login" : "Signup",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isLogin
                              ? "Don't have an account?"
                              : "Already have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.isLogin = !widget.isLogin;
                              _formKey.currentState!.reset();
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: Text(
                            widget.isLogin ? "Sign up" : "Login",
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
