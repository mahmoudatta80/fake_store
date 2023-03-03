import 'package:flutter/material.dart';
import 'package:store_app/helper/db_helper.dart';
import 'package:store_app/layout/home_layout.dart';
import 'package:store_app/models/db_models/cards.dart';
import 'package:store_app/models/db_models/favourites.dart';
import 'package:store_app/modules/details.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<String> categories = [
    'Electronics',
    'Jewelery',
    'Men\'s clothing',
    'Women\'s clothing',
    'Electronics',
    'Jewelery',
    'Men\'s clothing',
    'Women\'s clothing',
    'Electronics',
    'Jewelery',
    'Men\'s clothing',
    'Women\'s clothing'
  ];
  List<String> categoryImages = [
    'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
    'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
    'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
    'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg'
  ];
  DbHelper? helper;
  FavouritesModel? favouritesModel;
  List list = [];
  bool testIsCard = true;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    helper!.readAllCard().then((value) {
      list = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              child: FutureBuilder(
                future: helper!.readAllFavourites(),
                builder: (context, AsyncSnapshot? snapshot) {
                  if (snapshot!.hasData) {
                    if (snapshot.data.length > 0) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          favouritesModel =
                              FavouritesModel.fromJson(snapshot.data[index]);
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 8,
                              end: 8,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        id: snapshot.data[index]['id']),
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
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Image(
                                          image: NetworkImage(
                                            '${favouritesModel!.image}',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CircleAvatar(
                                          radius: 17,
                                          backgroundColor: Colors.grey,
                                          child: IconButton(
                                            onPressed: () {
                                              helper!.deleteFromFavourites(snapshot.data[index]['id']);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
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
                                    '${favouritesModel!.title}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$ ${favouritesModel!.price}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          CardsModel cardsModel = CardsModel({
                                            'id': snapshot.data[index]['id'],
                                            'title': snapshot.data[index]
                                                ['title'],
                                            'image': snapshot.data[index]
                                                ['image'],
                                            'price': snapshot.data[index]
                                                ['price'],
                                          });
                                          list.forEach((e) {
                                            if (e['id'] ==
                                                snapshot.data[index]['id']) {
                                              setState(() {
                                                testIsCard = false;
                                              });
                                            }
                                          });
                                          testIsCard
                                              ? helper!
                                                  .insertToCard(cardsModel)
                                              : null;
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
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const[
                            Icon(
                              Icons.menu_outlined,
                              size: 60,
                              color: Colors.red,
                            ),
                            Text(
                              'Favourite list is empty',
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
