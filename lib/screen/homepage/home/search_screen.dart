import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/providers/product_provider.dart';
import 'package:grocery_app/screen/homepage/home/product_detail.dart';
import 'package:grocery_app/screen/utils/data.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Product> products = [];
  List<Product> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    products = Provider.of<ProductProvider>(context, listen: false).products;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String keyword = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems =
          products
              .where((item) => item.name.toLowerCase().contains(keyword))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search keywords...",
                          suffixIcon: Icon(Icons.density_medium_sharp),
                          disabledBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              await Future.delayed(Duration(milliseconds: 500));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ProductDetail(product: _filteredItems[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(_filteredItems[index].image),
                  ),
                  title: Text(_filteredItems[index].name),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
