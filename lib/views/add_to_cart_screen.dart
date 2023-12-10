import 'package:flutter/material.dart';
import 'package:flutter_application_3/utils/app_colors.dart';

class AddToCartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  AddToCartScreen({required this.cartItems});

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text("No items found in the cart !"),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: AppColors.primary,
                    selectedTileColor: AppColors.primary,
                    leading: Image.asset("assets/leather.png"),
                    title: Text(widget.cartItems[index]['name']),
                    subtitle:
                        Text('Price: ${widget.cartItems[index]['price']}'),
                  ),
                );
              },
            ),
    );
  }
}
