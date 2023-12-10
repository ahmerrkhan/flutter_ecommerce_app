import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/views/product_listing_screen.dart';
import 'package:flutter_application_3/models/get_product_list_model.dart';
import 'package:get/get.dart';

class ApiService {
  static final Dio _dio = Dio();
  static Future<void> userLogin(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://demo.aalogics.com/rest/V1/integration/customer/token?',
        data: {
          "username": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.data}');
        Get.snackbar("Success", "User Login Successfully",
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue);
        Get.to(() => const HomeScreen());
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Invalid username or password",
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent);
      } else {
        print('Error - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Error", "Invalid username or password",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent);
    }
  }

  ///Get Product Listings
  static Future<void> fetchData() async {
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
      final List<Map<String, dynamic>> items =
          (response.data[0]['items'] as List).cast<Map<String, dynamic>>();

    
      List<GetProductListModel> productList = items
          .map((item) => GetProductListModel.fromJson(item))
          .toList();

     
      for (var product in productList) {
        print('Entity ID: ${product.entityId}');
        print('Price: ${product.price}');
        print('Special Price: ${product.specialPrice}');
        print('Image: ${product.image}');
        print('Rating: ${product.rating}');
        print('-------------------------');
      }

      
    } else {
      print('Error - Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

}
