import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:grocery_app/screen/home_page.dart';

import 'package:http/http.dart' as http;

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Order Success"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 150, color: Colors.green),
            Text(
              "Your order was successful !",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "You will get a response within\na few minutes",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            await sendNotificationToDevice(
              "eSneDMl_T1KqM-mlQsgn0J:APA91bHhHgH9vgXUoutd0KBmHYIGksAlimJTvtEVBsWsnTrlAXUeVEg95Lptx-c_Ah03p377AsNG8So3P0Ukg3Xmdj26TgWLKBgm2OMxNgjl3V0LvTCVk6w",
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text("Continue Shopping"),
        ),
      ),
    );
  }
}

Future<void> sendNotificationToDevice(String fcmToken) async {
  // Load service account credentials
  final jsonCredentials = await rootBundle.loadString(
    'assets/serviceAccountKey.json',
  );
  final Map<String, dynamic> decoded = json.decode(jsonCredentials);

  final serviceAccount = ServiceAccountCredentials.fromJson(decoded);

  const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  final client = await clientViaServiceAccount(serviceAccount, scopes);
  final projectId = decoded['project_id'];

  final url = Uri.parse(
    'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
  );

  final message = {
    'message': {
      'token': fcmToken,
      'notification': {
        'title': 'Grocery Manage',
        'body': 'Bạn có đơn hàng mới',
      },
    },
  };

  final response = await client.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(message),
  );

  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
  client.close();
}
