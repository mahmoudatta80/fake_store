import 'package:flutter/material.dart';
import 'package:store_app/layout/home_layout.dart';
import 'package:store_app/modules/single_category.dart';

class CategoriesScreen extends StatelessWidget {
  List<String> categories = [
    'electronics',
    'jewelery',
    'men\'s clothing',
    'women\'s clothing'
  ];
  List<String> categoryImages = [
    'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
    'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeLayout(),
            ),
                (route) => false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              25,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.black87,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          cursorColor: Colors.black87,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black45,
                            ),
                            suffixIcon: Icon(
                              Icons.mic,
                              color: Colors.black45,
                            ),
                            focusColor: Colors.black87,
                            fillColor: Colors.black87,
                            hoverColor: Colors.black87,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.double_arrow_outlined,
                        color: Colors.red,
                        size: 27,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SingleCategoryScreen(category: categories[index],isHome: false),
                        ));
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        child: Center(
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              child: Image(
                                image: NetworkImage(
                                  categoryImages[index],
                                ),
                              ),
                            ),
                            title: Text(
                              categories[index],
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: categories.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
