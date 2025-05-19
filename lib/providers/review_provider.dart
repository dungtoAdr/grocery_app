import 'package:flutter/material.dart';
import 'package:grocery_app/models/review.dart';
import 'package:grocery_app/services/api_service.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  Future<void> getReviews() async {
    _reviews = await ApiService.getReviews();
    notifyListeners();
  }

  Future<bool> addReview(Review review) async {
    bool success = await ApiService.addReview(review);
    if (success) {
      await getReviews();
    }
    return success;
  }
}
