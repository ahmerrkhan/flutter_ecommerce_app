import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/get_product_list_model.dart';
import 'package:flutter_application_3/views/sign_in_screen.dart';
import 'package:flutter_application_3/utils/app_colors.dart';
import 'package:get/get.dart';
import 'add_to_cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GetProductListModel> productList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List? jsonList;
  bool isFavourite = false;
  List _selectedIndexs = [];
  List<Map<String, dynamic>> cartItems = [];
  Future<void> fetchData() async {
    final Dio _dio = Dio();

    try {
      final response = await _dio.get(
        'https://demo.aalogics.com/rest/all/V1/aalogics-app/productlisting-api/',
        queryParameters: {
          'searchCriteria[filter_groups][0][filters][0][condition_type]': '',
          'searchCriteria[pageSize]': 10,
          'searchCriteria[filter_groups][0][filters][0][field]': 'visibility',
          'searchCriteria[currentPage]': 1,
          'searchCriteria[filter_groups][0][filters][0][value]': 4,
          'category_id': 3,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data[0]['items'] as List;
        });
        final List<Map<String, dynamic>> items =
            (response.data[0]['items'] as List).cast<Map<String, dynamic>>();

        // Convert each item to GetProductListModel
        List<GetProductListModel> productList =
            items.map((item) => GetProductListModel.fromJson(item)).toList();

        // Now productList contains a list of GetProductListModel objects
        for (var product in productList) {
          print('Entity ID: ${product.entityId}');
          print('Price: ${product.price}');
          print('Special Price: ${product.specialPrice}');
          print('Image: ${product.image}');
          print('Rating: ${product.rating}');
          print('-------------------------');
        }

        // Add further processing or UI updates here
      } else {
        print('Error - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Are you sure you want to exit ?"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        willLeave = true;
                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: const Center(
                          child: Text("Yes"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context);
                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: const Center(
                          child: Text("No"),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
        return willLeave;
      },
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(""),
              ),
              ListTile(
                title: const Text('Test User'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Log out'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignInScreen();
                  }));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddToCartScreen(cartItems: cartItems),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart))
          ],
          automaticallyImplyLeading: true,
          title: const Text("Product Listing Screen"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final _isSelected = _selectedIndexs.contains(index);
                final specialPrice = jsonList?[index]['special_price'] == null
                    ? "-"
                    : jsonList?[index]['special_price'];
                return Stack(
                  children: [
                    Container(
                      height: 320,
                      width: 175,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Image.asset("assets/leather.png")),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: AppColors.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "${jsonList?[index]['name']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "Price: ${jsonList?[index]['price']}",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      "Special Price: $specialPrice",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      "Ratings : ${jsonList?[index]['rating']}",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        color: Colors.pink,
                        onPressed: () {
                          setState(() {
                            if (_isSelected) {
                              _selectedIndexs.remove(index);
                              cartItems.removeWhere(
                                  (item) => item == jsonList?[index]);
                            } else {
                              _selectedIndexs.add(index);
                              cartItems.add(jsonList?[index] ?? {});
                            }
                          });

                          String snackbarMessage = _isSelected
                              ? "Item removed from the cart"
                              : "Item added to the cart";

                          Get.snackbar(
                            "Success",
                            snackbarMessage,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.blue,
                          );
                        },
                        icon: Icon(
                          _isSelected
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 20,
                        )),
                  ],
                );
              },
              itemCount: jsonList == null ? 0 : jsonList?.length,
            )),
      ),
    );
  }
}
