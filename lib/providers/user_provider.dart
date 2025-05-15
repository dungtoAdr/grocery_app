import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/profile_user.dart';
import 'package:grocery_app/services/api_service.dart';

class UserProvider extends ChangeNotifier {
  List<ProfileUser> _users = [];

  List<ProfileUser> get users => _users;

  Future<void> getUsers() async {
    _users = await ApiService.getUsers();
    notifyListeners();
  }

  Future<bool> updateUser(ProfileUser user) async {
    bool success = await ApiService.updateUser(user);
    if (success) {
      await getUsers();
    }
    return success;
  }

  Future<bool> addUser(ProfileUser user) async {
    bool success = await ApiService.addUser(user);
    if (success) {
      await getUsers();
    }
    return success;
  }
}
