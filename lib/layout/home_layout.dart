import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app/helper/dio_helper.dart';
import 'package:store_app/models/dio_models/products.dart';
import 'package:store_app/modules/card.dart';
import 'package:store_app/modules/favourite.dart';
import 'package:store_app/modules/home.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> screens = [
    HomeScreen(product: product,favourites: favourites),
    const FavouriteScreen(),
    const CardScreen(),
    const Center(child: Text('Person',style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold,),),),
  ];
  int currentIndex = 0;
  static List<ProductModel> product = [];
  static Map<int,bool> favourites = {};
  List listOfFavourites = [];

  ProductModel? productModel;
  @override
  void initState() {
    super.initState();
    DioHelper.getProduct().then((value) {
      value.data.forEach((e) {
        setState(() {
          product.add(ProductModel.fromJson(e));
        });
      });
    }).then((value) {
      product.forEach((e) {
        favourites.addAll({
          e.id!:false,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: DioHelper.getProduct(),
        builder: (context, snapshot) {
          if(product.isNotEmpty&&favourites!={}) {
            return screens[currentIndex];
          }else {
            return const Center(child: CircularProgressIndicator(color: Colors.red,));
          }
        },
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25,),
            topLeft: Radius.circular(25,),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: Colors.black87,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontSize: 15,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
          ),
          selectedIconTheme: const IconThemeData(
            size: 25,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 25,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
              ),
              label: 'Card',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

