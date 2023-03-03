import 'package:flutter/material.dart';
import 'package:store_app/helper/dio_helper.dart';
import 'package:store_app/modules/login.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

// get all product  https://fakestoreapi.com/products
// get single product https://fakestoreapi.com/products/[id]
// get all categories  https://fakestoreapi.com/products/categories
// get single categories  https://fakestoreapi.com/products/category/[categoryTitle]

// task was finished except get single product and accounting total price in card screen
