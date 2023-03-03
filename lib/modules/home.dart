import 'package:flutter/material.dart';
import 'package:store_app/helper/db_helper.dart';
import 'package:store_app/models/db_models/cards.dart';
import 'package:store_app/models/db_models/favourites.dart';
import 'package:store_app/models/dio_models/products.dart';
import 'package:store_app/modules/categories.dart';
import 'package:store_app/modules/details.dart';
import 'package:store_app/modules/single_category.dart';

class HomeScreen extends StatefulWidget {
  List<ProductModel>? product;
  Map<int, bool>? favourites;
  Map<int, bool>? cards;

  HomeScreen({this.product, this.favourites,this.cards});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  List listOfCards = [];
  List listOfFavourites = [];
  DbHelper? helper;
  bool testIsCard = true;
  bool checkComplete = false;

  @override
  void initState() {
    super.initState();
    checkComplete = false;
    setState(() {});
    helper = DbHelper();
    helper!.readAllCard().then((value) {
      listOfCards = value;
    });
    helper!.readAllFavourites().then((value) {
      listOfFavourites = value;
      widget.favourites={};
      widget.product!.forEach((e) {
        widget.favourites!.addAll({
          e.id!:false,
        });
      });
    }).then((value) {
      listOfFavourites.forEach((e) {
        widget.product!.forEach((m) {
          if (e['id'] == m.id) {
            widget.favourites![m.id!]=true;
          }
        });
      });
      checkComplete = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: checkComplete
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
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
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 120,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  InkWell(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                15,
                                              ),
                                            ),
                                          ),
                                          height: 90,
                                          width: 90,
                                          child: const Icon(
                                            Icons.apps_outlined,
                                            size: 65,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'All',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CategoriesScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 15,
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => InkWell(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  15,
                                                ),
                                              ),
                                            ),
                                            height: 90,
                                            width: 90,
                                            child: Image(
                                              image: NetworkImage(
                                                categoryImages[index],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            categories[index],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingleCategoryScreen(category: categories[index],isHome: true,),
                                          ),
                                        );
                                      },
                                    ),
                                    itemCount: categories.length,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 3.5,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Product',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 8,
                                    end: 8,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(id: widget.product![index].id!,),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              height: 120,
                                              width: double.infinity,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15,
                                                ),
                                              ),
                                              child: Image(
                                                image: NetworkImage(
                                                  '${widget.product![index].image}',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.grey,
                                                child: IconButton(
                                                  onPressed: () {
                                                    FavouritesModel favouritesModel = FavouritesModel({
                                                      'id': widget.product![index].id,
                                                      'title': widget.product![index].title,
                                                      'image': widget.product![index].image,
                                                      'price': widget.product![index].price,
                                                    });
                                                    widget.favourites![widget.product![index].id!]! ?
                                                    setState(() {
                                                      widget.favourites![widget.product![index].id!] = false;
                                                            helper!.deleteFromFavourites(widget.product![index].id!);
                                                    })
                                                        :
                                                    setState(() {
                                                      widget.favourites![widget.product![index].id!] = true;
                                                            helper!.insertToFavourites(favouritesModel);
                                                    });
                                                  },
                                                  icon: widget.favourites![
                                                          widget.product![index]
                                                              .id]!
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                          size: 20,
                                                        )
                                                      : const Icon(
                                                          Icons.favorite,
                                                          color: Colors.black,
                                                          size: 20,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${widget.product![index].title}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '\$ ${widget.product![index].price}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                CardsModel cardsModel = CardsModel({
                                                  'id': widget.product![index].id,
                                                  'title': widget.product![index].title,
                                                  'image': widget.product![index].image,
                                                  'price': widget.product![index].price,
                                                });
                                                listOfCards.forEach((e) {
                                                  if(e['id'] == widget.product![index].id) {
                                                    setState(() {
                                                      testIsCard = false;
                                                    });
                                                  }
                                                });
                                                testIsCard ? helper!.insertToCard(cardsModel) : null;
                                                setState(() {
                                                  testIsCard = true;
                                                });
                                              },
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              )),
      ),
    );
  }
}
