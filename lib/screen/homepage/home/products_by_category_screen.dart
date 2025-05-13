import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/screen/utils/data.dart';
import 'package:grocery_app/screen/utils/product_item.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final int? id;
  final String? name;

  const ProductsByCategoryScreen({super.key, this.id, this.name});

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  late List<Product> products;
  late List<Product> productsByCate;
  late List<Product> list;
  bool _isTimeOut = false;

  @override
  void initState() {
    super.initState();
    products = Data.products;
    productsByCate =
        products.where((product) => product.category_id == widget.id).toList();
    if (widget.id == null) {
      list = products;
    } else {
      list = productsByCate;
    }
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isTimeOut = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.name ?? 'Products'),
        centerTitle: true,
      ),
      body:
          list.isEmpty
              ? Center(
                child:
                    !_isTimeOut
                        ? CircularProgressIndicator()
                        : Text("Products is empty"),
              )
              : Padding(
                padding: EdgeInsets.all(5),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 250,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final product = list[index];
                    return ProductItem(product: product);
                  },
                ),
              ),
    );
  }
}
