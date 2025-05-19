import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocery_app/models/review.dart';
import 'package:grocery_app/providers/review_provider.dart';
import 'package:provider/provider.dart';

class ReviewsScreen extends StatefulWidget {
  final int id;

  const ReviewsScreen({super.key, required this.id});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final contentController = TextEditingController();
  final rateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ReviewProvider>(context, listen: false).getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Review"),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: ,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Content",
                            ),
                            controller: contentController,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Rate",
                            ),
                            keyboardType: TextInputType.number,
                            controller: rateController,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Provider.of<ReviewProvider>(
                                  context,
                                  listen: false,
                                ).addReview(
                                  Review(
                                    content: contentController.text,
                                    rates: double.parse(rateController.text),
                                    user_uid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    product_id: widget.id,
                                  ),
                                );
                                Navigator.pop(context);
                                _formKey.currentState!.reset();
                              }
                            },
                            child: Text("Review"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: Consumer<ReviewProvider>(
        builder: (context, value, child) {
          List<Review> reviews = value.reviews;
          List<Review> reviewsId =
              reviews
                  .where(
                    (element) => element.product_id.toString().contains(
                      widget.id.toString(),
                    ),
                  )
                  .toList();
          return ListView.builder(
            itemCount: reviewsId.length,
            itemBuilder: (context, index) {
              final review = reviewsId[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(child: Icon(Icons.person)),
                            SizedBox(width: 10),
                            Text(
                              review.user_name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(review.rates.toString()),
                            SizedBox(width: 5),
                            RatingBarIndicator(
                              rating: review.rates,
                              itemBuilder:
                                  (context, index) =>
                                      Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Text(
                          review.content,
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
