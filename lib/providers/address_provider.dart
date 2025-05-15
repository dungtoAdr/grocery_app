import 'package:flutter/material.dart';
import 'package:grocery_app/models/address.dart';
import 'package:grocery_app/services/api_service.dart';

class AddressProvider extends ChangeNotifier {
  List<Address> _addresses = [];

  List<Address> get addresses => _addresses;

  Future<void> getAddress() async {
    _addresses = await ApiService.getAddress();
    notifyListeners();
  }

  Future<bool> addAddress(Address address) async {
    bool success = await ApiService.addAddress(address);
    if (success) {
      await getAddress();
    }
    return success;
  }

  Future<bool> updateAddress(Address address) async {
    bool success = await ApiService.updateAddress(address);
    if (success) {
      await getAddress();
    }
    return success;
  }
}
